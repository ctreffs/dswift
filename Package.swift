// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dswift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        
        .package(url: "https://github.com/TheAngryDarling/SwiftXcodeProj.git", from: "1.0.8"),
        .package(url: "https://github.com/TheAngryDarling/SwiftBasicCodableHelpers.git", from: "1.1.6"),
    
        .package(url: "https://github.com/TheAngryDarling/SwiftPatches.git", from: "1.0.3"),
        
        .package(url: "https://github.com/TheAngryDarling/SwiftVersionKit.git", from: "1.0.3"),
        .package(url: "https://github.com/TheAngryDarling/SwiftRegEx.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package
        // depends on.
        .target(
            name: "dswift",
            dependencies: ["XcodeProj", "PBXProj", "SwiftPatches", "VersionKit", "RegEx", "BasicCodableHelpers"])
    ]
)
