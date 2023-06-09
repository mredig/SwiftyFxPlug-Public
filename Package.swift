// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyFxPlug",
	platforms: [
		.macOS("11.5.1"),
	],
	products: [
		.library(name: "SwiftyFxPlug", targets: ["SwiftyFxPlug"]),
		.plugin(name: "SetupXCFrameworks", targets: ["SetupXCFrameworks"]),
	],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
		.package(url: "https://github.com/SusanDoggie/Float16.git", .upToNextMinor(from: "1.1.0")),
    ],
	targets: [
		.binaryTarget(name: "FxPlug", path: "xcframeworks/FxPlug.xcframework"),
		.binaryTarget(name: "PluginManager", path: "xcframeworks/PluginManager.xcframework"),
		.target(
			name: "SwiftyFxPlug",
			dependencies: [
				"PluginManager",
				"FxPlug",
				"Float16",
			]),
		.plugin(
			name: "SetupXCFrameworks",
			capability: .command(
				intent: .custom(
					verb: "xcframeworkInstall",
					description: "Pull the FxPlug and PluginManager frameworks installed from Apple's website into the `xcframeworks` directory, while configuring headers and modulemap files.."),
				permissions: [.writeToPackageDirectory(reason: "That's how it works.")]))
	]
)

