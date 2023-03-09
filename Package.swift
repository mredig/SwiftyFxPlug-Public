// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyFxPlug",
	platforms: [
		.macOS(.v12),
	],
	products: [
		.library(name: "SwiftyFxPlug", targets: ["SwiftyFxPlug"]),
	],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
	targets: [
		.binaryTarget(name: "FxPlug", path: "xcframeworks/FxPlug.xcframework"),
		.binaryTarget(name: "PluginManager", path: "xcframeworks/PluginManager.xcframework"),
		.target(
			name: "SwiftyFxPlug",
			dependencies: [
				"PluginManager",
				"FxPlug",
			]) 
	]
)

