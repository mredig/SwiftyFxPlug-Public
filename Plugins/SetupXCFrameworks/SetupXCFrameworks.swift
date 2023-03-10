import PackagePlugin
import Foundation

@main
struct SetupXCFrameworks: CommandPlugin {
	let fm = FileManager.default

	static private let fxPlugName = "FxPlug"
	static private let pluginManagerName = "PluginManager"
	static private let frameworkExtension = "framework"

	func performCommand(context: PluginContext, arguments: [String]) async throws {
		// basic directories
		let packageDir = URL(fileURLWithPath: context.package.directory.string)
		let xcframeworksDir = packageDir.appendingPathComponent("xcframeworks")

		// source paths
		let sourceFrameworksPath = URL(fileURLWithPath: "/Library/Developer/Frameworks")
		let fxplugSourcePath = sourceFrameworksPath
			.appendingComponent(Self.fxPlugName, withExtension: Self.frameworkExtension)
		let pluginManagerSourcePath = sourceFrameworksPath
			.appendingComponent(Self.pluginManagerName, withExtension: Self.frameworkExtension)
		let sourceSDKFrameworksPath = URL(fileURLWithPath: "/Library/Developer/SDKs/FxPlug.sdk/Library/Frameworks")

		// cleanup, before and after
		let tmpDir = fm.temporaryDirectory.appendingPathComponent("fxplugbuild")
		defer {
			if arguments.contains("--no-cleanup") == false {
				do {
					try fm.removeItem(at: tmpDir)
				} catch {
					print("Error cleaning up: \(error)")
				}
			}
		}
		do {
			try fm.removeItem(at: tmpDir)
			try fm.removeItem(at: xcframeworksDir)
		} catch {
			//meh
		}
		try fm.createDirectory(at: tmpDir, withIntermediateDirectories: true)

		// building in temp dir
		let tmpFxPlug = tmpDir.appendingComponent(Self.fxPlugName, withExtension: Self.frameworkExtension, isDirectory: true)
		let tmpFxPlugCurrent = tmpFxPlug
			.appendingPathComponent("Versions")
			.appendingPathComponent("Current", isDirectory: true)
		let tmpPM = tmpDir.appendingComponent(Self.pluginManagerName, withExtension: Self.frameworkExtension, isDirectory: true)
		let tmpPMCurrent = tmpPM
			.appendingPathComponent("Versions")
			.appendingPathComponent("Current", isDirectory: true)

		try fm.copyItem(at: fxplugSourcePath, to: tmpFxPlug)
		try fm.copyItem(at: pluginManagerSourcePath, to: tmpPM)

		// headers
		let fxHeadersSource = sourceSDKFrameworksPath
			.appendingComponent(Self.fxPlugName, withExtension: Self.frameworkExtension)
			.appendingPathComponent("Versions")
			.appendingPathComponent("Current")
			.appendingPathComponent("Headers")
		let fxHeadersDestination = tmpFxPlugCurrent
			.appendingPathComponent("Headers")

		let pmHeadersSource = sourceSDKFrameworksPath
			.appendingComponent(Self.pluginManagerName, withExtension: Self.frameworkExtension)
			.appendingPathComponent("Versions")
			.appendingPathComponent("Current")
			.appendingPathComponent("Headers")
		let pmHeadersDestination = tmpPMCurrent
			.appendingPathComponent("Headers")

		try fm.copyItem(at: fxHeadersSource, to: fxHeadersDestination)
		try fm.copyItem(at: pmHeadersSource, to: pmHeadersDestination)

		// fix FxPlugSDK umbrella Header file
		let fxSDKHeaderFile = fxHeadersDestination.appendingComponent("FxPlugSDK", withExtension: "h")
		var fxSDKHeaderData = try Data(contentsOf: fxSDKHeaderFile)
		var fxSDKHeader = String(data: fxSDKHeaderData, encoding: .utf8)!
		fxSDKHeader = fxSDKHeader.replacingOccurrences(of: FileContent.fxPlugSDKRemoveText, with: FileContent.fxPlugSDKReplaceText)
		fxSDKHeaderData = Data(fxSDKHeader.utf8)
		try fxSDKHeaderData.write(to: fxSDKHeaderFile)

		// create PluginManager Umbrella header
		let pmSDKHeaderFile = pmHeadersDestination.appendingComponent("PluginManagerSDK", withExtension: "h")
		let pmSDKHeaderData = Data(FileContent.pluginManagerHeaderContents.utf8)
		try pmSDKHeaderData.write(to: pmSDKHeaderFile)

		// header symlinks
		let headersSymlinkDestination = URL(string: "Versions/Current/Headers", relativeTo: nil)!
		try fm.createSymbolicLink(at: tmpFxPlug.appendingPathComponent("Headers"), withDestinationURL: headersSymlinkDestination)
		try fm.createSymbolicLink(at: tmpPM.appendingPathComponent("Headers"), withDestinationURL: headersSymlinkDestination)

		// module maps
		let fxSwiftHeader = tmpFxPlugCurrent
			.appendingPathComponent("Headers")
			.appendingComponent("\(Self.fxPlugName)-Swift", withExtension: "h")
		let pmSwiftHeader = tmpPMCurrent
			.appendingPathComponent("Headers")
			.appendingComponent("\(Self.pluginManagerName)-Swift", withExtension: "h")

		try Data().write(to: fxSwiftHeader)
		try Data().write(to: pmSwiftHeader)

		let fxModulesFolder = tmpFxPlugCurrent.appendingPathComponent("Modules")
		let pmModulesFolder = tmpPMCurrent.appendingPathComponent("Modules")
		try fm.createDirectory(at: fxModulesFolder, withIntermediateDirectories: true)
		try fm.createDirectory(at: pmModulesFolder, withIntermediateDirectories: true)

		let fxModulemap = fxModulesFolder.appendingComponent("module", withExtension: "modulemap")
		let pmModulemap = pmModulesFolder.appendingComponent("module", withExtension: "modulemap")

		try Data(FileContent.moduleMapFileContents(forFrameworkTitled: Self.fxPlugName).utf8).write(to: fxModulemap)
		try Data(FileContent.moduleMapFileContents(forFrameworkTitled: Self.pluginManagerName).utf8).write(to: pmModulemap)

		// module symlinks
		let fxModuleSymlink = tmpFxPlug.appendingPathComponent("Modules")
		let pmModuleSymlink = tmpPM.appendingPathComponent("Modules")
		let modulesSymlinkDestination = URL(string: "Versions/Current/Modules", relativeTo: nil)!
		try fm.createSymbolicLink(at: fxModuleSymlink, withDestinationURL: modulesSymlinkDestination)
		try fm.createSymbolicLink(at: pmModuleSymlink, withDestinationURL: modulesSymlinkDestination)

		// compile to xcframeworks
		try xcframeworkBuild(inputFramework: tmpFxPlug, xcframeworkOutputDirectory: xcframeworksDir)
		try xcframeworkBuild(inputFramework: tmpPM, xcframeworkOutputDirectory: xcframeworksDir)
	}

	private func xcframeworkBuild(inputFramework: URL, xcframeworkOutputDirectory: URL) throws {
		let title = inputFramework.deletingPathExtension().lastPathComponent

		let args = [
			"xcodebuild -create-xcframework -framework \(inputFramework.path) -output \(xcframeworkOutputDirectory.path)/\(title).xcframework",
		]

		let command = Process()
		let pipe = Pipe()

		command.standardOutput = pipe
		command.standardError = pipe
		command.executableURL = URL(fileURLWithPath: "/bin/zsh")
		command.arguments = ["-c"] + args

		try command.run()
		let output = pipe.fileHandleForReading

		if #available(macOS 12.0, *) {
			Task {
				let bytes = output.bytes

				var buffer = Data()
				for try await byte in bytes {
					buffer.append(byte)
					guard byte == "\n".utf8.first else { continue }
					let string = String(data: buffer, encoding: .utf8)
					defer { buffer = Data() }
					guard let string else { return }
					print(string)
				}
			}
		}

		command.waitUntilExit()

		let result = command.terminationStatus
		guard result == 0 else {
			throw NSError(domain: "XCFrameworkFailure", code: -1, userInfo: ["StatusOutput": result])
		}
	}
}
