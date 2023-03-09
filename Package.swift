// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FxPlugSPM",
	platforms: [
		.macOS(.v12),
	],
	products: [
//		.library(name: "FxPlug", targets: ["FxPlug"]),
//		.library(name: "PluginManager", targets: ["PluginManager"]),
		.library(name: "Test", targets: ["Test"]),
	],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
	targets: [
//		.systemLibrary(name: "PluginManager", path: nil, pkgConfig: nil, providers: nil),
//		.systemLibrary(name: "FxPlug", path: nil, pkgConfig: nil, providers: nil),
		.binaryTarget(name: "FxPlug", path: "xcframeworks/FxPlug.xcframework"),
		.binaryTarget(name: "PluginManager", path: "xcframeworks/PluginManager.xcframework"),
		.target(
			name: "Test",
			dependencies: [
				"PluginManager",
				"FxPlug",
			]) 
	]
)

