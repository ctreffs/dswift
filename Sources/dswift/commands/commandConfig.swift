//
//  commandPrepConfig.swift
//  dswift
//
//  Created by Tyler Anger on 2019-07-24.
//

import Foundation
import XcodeProj

extension Commands {
    // swiftlint:disable:next line_length
    private static let defaultConfig: String = """
{
    // (Optional, If not set \(DSwiftSettings.defaultSwiftPath) is used) The default swift path to use unless specificed in the command line
    // "swiftPath": "\(DSwiftSettings.defaultSwiftPath)",

    // Sort files and folders within the project
    // "none":  No sorting
    // "sorted": Sort by name, folders first. Except for root, the root has files before folders and folders are in a special order, and Package.swift will always be at the top
    "xcodeResourceSorting": "none",

    // Auto create a license file for the project
    // "none": No license
    // "apache2_0": Apache License 2.0
    // "gnuGPL3_0": GNU GPLv3
    // "gnuAGPL3_0": GNU AGPLv3
    // "gnuLGPL3_0": GNU LGPLv3
    // "mozilla2_0": Mozilla Public License 2.0
    // "mit": MIT License
    // "unlicense": The Unlicense
    // address to file (Local path address, or web address)
    "license": "none",
    
    // The path the the specific read me files.  If set, and the file exists, it will be copied into the project replacing the standard one
    // Valid values are:
    //readme: "{path to read me file for all project types}" OR "generated"
    // OR
    // Please note, each property is optional
    // "readme": {
    //      "executable": "{path to read me file for all executable projects}" OR "generated",
    //      "library": "{path to read me file for all library projects}" OR "generated",
    //      "system-module": "{path to read me file for all system-module projects}" OR "generated",
    //      "other project type": "{path to read me file for other project type}" OR "generated",
    //      "default": "{path to read me file for all other project types}" OR "generated",
    // },

    // Author Name.  Used when generated README.md as the author name
    // If author name is not set, the application wil try and use env variable REAL_DISPLAY_NAME if set otherwise use the current use display name from the system
    // "authorName": "YOUR NAME HERE",

    // Provides an indicator of when to add the build rules to the Xcode Project.
    //      always: Even if there are no custom build files
    //      whenNeeded: Only when there are custom build files
    // "whenToAddBuildRules": "always" OR "whenNeeded",

    // (Optional, Default: false) Generate Xcode Project on package creation if the flag is true
    // "generateXcodeProjectOnInit": true,
    // "generateXcodeProjectOnInit": {
    //      "library": true,
    //      "executable": true,
    //      "system-module": true,
    //      "other project type": true,
    //      "default": true,
    // },

    // Regenerate Xcode Project (If already exists) when package is updated
    "regenerateXcodeProject": false,

    // Your public repositor information.  This is used when auto-generating readme files
    // "repository": "https://github.com/YOUR REPOSITORY", <-- Sets the Service URL and repository name
    // OR
    // Please note, serviceName and repositoryName are optional
    // "repository": {
    //      "serviceName": "GitHub",
    //      "serviceURL": "https://github.com/YOUR REPOSITORY",
    //      "repositoryName": "YOUR REPOSITORY NAME",
    // },

    // (Optional, Default: true) Lock generated files from being modified manually
    // "lockGenratedFiles": true,

    // (Optional, Default: false) Indicator if generated files should be kepted in Xcode Project when generating / updating project
    // "includeGeneratedFilesInXcodeProject": false,

    // (Optional, Default: never) Indicator if, when generating Xcode Project file, the application should install SwiftLint Build Phase Run Script if SwiftLint is installed.  Options: always, whenAvailable, never
    // "includeSwiftLintInXcodeProject": "never",

    // (Optional, Default: false) Indicator if we should try to auto install any missing system packages from the package manager
    // when requirements are found within the project, otherwise we will just give a warning.
    // Note: If dswift was built with the flag AUTO_INSTALL_PACKAGES.  This property is always true no matter what the configuration value is set to
    // "autoInstallMissingPackages": false,
    
    // (Optional, Default: null/nil) Provides an option to override the default gitignore contents that dswift generates
    // "defaultGitIgnore": {
    //      "items": [
    //          "Rule",
    //          "# Comment",
    //      ],
    //      "sections": [
    //          {
    //              "name": "Section Name",
    //              "description": [
    //                  "Description array seperated by lines",
    //              ],
    //              "items": [
    //                  "Rule",
    //                  "# Comment",
    //              ],
    //              subsections: [
    //                  {
    //                      "name": "Sub Section Name",
    //                      "items": [
    //                          "Rule",
    //                          "# Comment",
    //                      ],
    //                  },
    //              ]
    //          },
    //      ]
    // },

    // (Optional, Default: null/nil) Provides an option to add additional items to the gitignore.
    // This structure is the same as defaultGitIgnore.  This object will be combined with the
    // default gitignore in the following way:
    // 1. All comments are ignored.
    // 2. I will first try and and see if the rule exists somewhere else before adding
    // 3. If the default gitignore has the same section with no description, the addition description will
    //   be copied
    // 4. Any sections/subsections that become empty due to rules already existing will not be added
    
    // "gitIgnoreAdditions": {
    //      "items": [
    //          "Rule",
    //      ],
    //      "sections": [
    //          {
    //              "name": "Section Name",
    //              "description": [
    //                  "Description array seperated by lines",
    //              ],
    //              "items": [
    //                  "Rule",
    //              ],
    //              subsections: [
    //                  {
    //                      "name": "Sub Section Name",
    //                      "items": [
    //                          "Rule",
    //                      ],
    //                  },
    //              ]
    //          },
    //      ]
    // },
}
"""
    /// Method for setting up default dswift configuration
    static func commandConfig(_ args: [String]) -> Int32 {
        let url = URL(fileURLWithPath: NSString(string: dswiftSettingsFilePath).expandingTildeInPath).standardizedFileURL.resolvingSymlinksInPath()
        do {
            guard !FileManager.default.fileExists(atPath: url.path) else {
                print("File '\(dswiftSettingsFilePath)' already exists")
                return 0
            }

            var configStr = defaultConfig
            if let userDisplayName = XcodeProjectBuilders.UserDetails().displayName, userDisplayName != "root" {
                configStr = configStr.replacingOccurrences(of: "// \"authorName\": \"YOUR NAME HERE\",",
                                                           with: "\"authorName\": \"\(userDisplayName)\",")
            }
            try configStr.write(to: url, atomically: true, encoding: .utf8)
            
            return 0
            
        } catch {
            errPrint("An error has occured:\n\(error)")
            return 1
        }
    }
}
