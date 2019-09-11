import Foundation
import VersionKit

let dSwiftVersion: String = "1.0.4"
let dSwiftModuleName: String = "Dynamic Swift"
let dswiftAppName: String = ProcessInfo.processInfo.arguments.first!.components(separatedBy: "/").last!
let dSwiftURL: String = "https://github.com/TheAngryDarling/dswift"
let dswiftFileExtension: String = "dswift"
let dswiftSettingsFilePath: String = "~/.\(dswiftAppName).config"
let isRunningFromXcode: Bool = (ProcessInfo.processInfo.environment["XCODE_VERSION_ACTUAL"] != nil)

var settings: DSwiftSettings = {
    let settingsPath = NSString(string: dswiftSettingsFilePath).standardizingPath
    guard FileManager.default.fileExists(atPath: settingsPath) else {
        return DSwiftSettings()
    }
    do {
        return try DSwiftSettings(from: URL(fileURLWithPath: settingsPath))
    } catch {
        errPrint("There was an error while loading dswift settings from '\(dswiftSettingsFilePath)'\n\(error)")
        return DSwiftSettings()
    }
}()
let swiftVersion: Version.SingleVersion

//var swiftPath: String = "/usr/bin/swift"

typealias PreCommandFunc = ([String]) throws -> Int32

typealias CustomCommandFunc = ([String]) throws -> Int32
typealias PostCommandFunc = ([String], Int32) throws -> Int32


let customExecutionCommands: [String: CustomCommandFunc] = ["--help": Commands.printUsage,
                                                            "-h": Commands.printUsage,
                                                            "--config": Commands.commandConfig,
                                                            "rebuild": Commands.commandRebuild,
                                                            "xcodebuild": Commands.commandXcodeBuild,
                                                            "package": Commands.commandPackage]
let preExecutionCommands: [String: PreCommandFunc] = ["build": Commands.commandDSwiftBuild,
                                                      "test": Commands.commandDSwiftBuild,
                                                      "--version": Commands.commandVersion,]
let postExecutionCommands: [String: PostCommandFunc] = [:]

let beginDSwiftSection: String = "---"
let endDSwiftSection: String = "---"

/// List of dswift parameters
var dswiftParams: [String] = []
/// List of swift parameters to pass onto swift
var swiftParams: [String] = []
/// Indictor if we are in the dswift parameter section
var isInDSwiftParamSection: Bool = false




var arguments = ProcessInfo.processInfo.arguments
arguments.removeFirst() //First parameter is the application path

#if NO_DSWIFT_PARAMS
    // If no dswift paramters supported, all parameters must be for swift
    swiftParams = arguments
#else

    for (i, p) in arguments.enumerated() {
        if i == 0 && p == beginDSwiftSection { isInDSwiftParamSection = true }
        else if (i > 0 && p == endDSwiftSection) { isInDSwiftParamSection = false }
        else if isInDSwiftParamSection { dswiftParams.append(p) }
        else { swiftParams.append(p) }
    }

    if let idx = dswiftParams.firstIndex(of: "--swiftPath"), idx < dswiftParams.count {
        settings.swiftPath = dswiftParams[idx + 1]
    }

#endif


let task = Process()

task.executable = URL(fileURLWithPath: settings.swiftPath)
task.arguments = ["--version"]

let pipe = Pipe()
defer {
    pipe.fileHandleForReading.closeFile()
    pipe.fileHandleForWriting.closeFile()
}
task.standardOutput = pipe
task.standardError = pipe

try! task.execute()
task.waitUntilExit()


let data = pipe.fileHandleForReading.readDataToEndOfFile()
let swiftVersionOutput = String(data: data, encoding: .utf8)!
var swiftVersionLine = swiftVersionOutput.split(separator: "\n").map(String.init).first!
guard let r = swiftVersionLine.range(of: "version ") else {
    errPrint("Unable to determine swift version from '\(swiftVersionLine)'")
    exit(1)
}

swiftVersionLine = String(swiftVersionLine.suffix(from: r.upperBound))

if let r = swiftVersionLine.range(of: " (") {
    swiftVersionLine = String(swiftVersionLine.prefix(upTo: r.lowerBound))
}

guard let v = Version.SingleVersion(swiftVersionLine) else {
    errPrint("Unable to determine swift version from '\(swiftVersionLine)'")
    exit(1)
}

swiftVersion = v

guard let swiftCommand = swiftParams.first else {
    print("Missing command")
    Commands.printUsage()
    exit(1)
}

guard customExecutionCommands.keys.contains(swiftCommand.lowercased()) ||
      preExecutionCommands.keys.contains(swiftCommand.lowercased()) ||
      postExecutionCommands.keys.contains(swiftCommand.lowercased()) else {
        print("Invalid command '\(swiftCommand)'")
        Commands.printUsage()
        exit(1)
}


// If we have the package path parameter, we should chanege the working path to reflect the new location
if let idx = swiftParams.firstIndex(of: "--package-path"), idx < (swiftParams.count - 1) {
    FileManager.default.changeCurrentDirectoryPath(swiftParams[idx + 1])
}

func processCommand(_ swiftParams: [String]) throws -> Int32 {
    guard let paramCommand = swiftParams.first else { return 0 }
    
    if let cmd = customExecutionCommands[paramCommand] {
        // Execute custom command, skippnig auto-call to swift
        return try cmd(swiftParams)
    } else {
        var returnCode: Int32 = 0
        if let cmd = preExecutionCommands[paramCommand] {
            // Call pre-swift commmand
            returnCode = try cmd(swiftParams)
        }
        
        guard returnCode == 0 else { return returnCode }
        
        // Call swift command
        returnCode = Commands.commandSwift(swiftParams)
        
        if let cmd = postExecutionCommands[paramCommand] {
            // call post-swift command
            returnCode = try cmd(swiftParams, returnCode)
        }
        
         return returnCode
    }
    
   
}

var returnCode: Int32 = try processCommand(swiftParams)
exit(returnCode)
