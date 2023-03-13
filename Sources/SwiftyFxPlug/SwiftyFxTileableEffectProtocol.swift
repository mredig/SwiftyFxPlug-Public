import FxPlug

public protocol UInt32Raw: RawRepresentable where RawValue == UInt32 {}

/**
Conform your plugin class to this protocol to create your plugin. This is the central point of Swifty FxPlug library.
 */
public protocol SwiftyFxTileableEffectProtocol {
	static func registerWithFactory()

	associatedtype PluginStateCodableData: Codable
	associatedtype ParameterID: UInt32Raw

	init(_ api: PROAPIAccessing)

	func finishInitialSetup() throws

	func pluginInstanceAddedToDocument()

	func pluginProperties() throws -> PluginPropertyConfiguration

	func addParameters() throws

	func parameterChanged(_ parameter: ParameterID, at time: CMTime) throws

	func createView(for parameter: ParameterID) -> NSView?

	func pluginState(at renderTime: CMTime, qualityLevel: UInt) throws -> PluginStateCodableData

	func destinationImageRect(sourceImages: [FxImageTile], destinationImage: FxImageTile, pluginState: PluginStateCodableData?, at renderTime: CMTime) throws -> FxRect

	func sourceTileRect(sourceImageIndex: UInt, sourceImages: [FxImageTile], destinationTileRect: FxRect, destinationImage: FxImageTile, pluginState: PluginStateCodableData?, at renderTime: CMTime) throws -> FxRect

	func renderDestinationImage(_ destinationImage: FxImageTile, sourceImages: [FxImageTile], pluginState: PluginStateCodableData?, at renderTime: CMTime) throws
}

fileprivate let pluginStateEncoder = JSONEncoder()
fileprivate let pluginStateDecoder = JSONDecoder()
public extension SwiftyFxTileableEffectProtocol {

	static func registerWithFactory() {
		EffectFactory.createPluginInstanceBlock = Self.init
	}

	func parameterChangedRaw(_ parameter: UInt32, at time: CMTime) throws {
		// could either silently fail or crash if there's a bad param id. I'd wager we want to know about bad ideas rather than let them slip by
		let param = ParameterID(rawValue: parameter)!
		try parameterChanged(param, at: time)
	}

	func createViewRaw(for parameter: UInt32) -> NSView? {
		// could either silently fail or crash if there's a bad param id. I'd wager we want to know about bad ideas rather than let them slip by
		let param = ParameterID(rawValue: parameter)!
		return createView(for: param)
	}

	func pluginStateData(at renderTime: CMTime, qualityLevel: UInt) throws -> Data {
		let codableData = try pluginState(at: renderTime, qualityLevel: qualityLevel)
		return try pluginStateEncoder.encode(codableData)
	}

	func destinationImageRect(sourceImages: [FxImageTile], destinationImage: FxImageTile, pluginStateData: Data?, at renderTime: CMTime) throws -> FxRect {
		let decodedObject: PluginStateCodableData?
		if let pluginStateData {
			decodedObject = try pluginStateDecoder.decode(PluginStateCodableData.self, from: pluginStateData)
		} else {
			decodedObject = nil
		}

		return try destinationImageRect(sourceImages: sourceImages, destinationImage: destinationImage, pluginState: decodedObject, at: renderTime)
	}

	func sourceTileRect(sourceImageIndex: UInt, sourceImages: [FxImageTile], destinationTileRect: FxRect, destinationImage: FxImageTile, pluginStateData: Data?, at renderTime: CMTime) throws -> FxRect {
		let decodedObject: PluginStateCodableData?
		if let pluginStateData {
			decodedObject = try pluginStateDecoder.decode(PluginStateCodableData.self, from: pluginStateData)
		} else {
			decodedObject = nil
		}

		return try sourceTileRect(sourceImageIndex: sourceImageIndex, sourceImages: sourceImages, destinationTileRect: destinationTileRect, destinationImage: destinationImage, pluginState: decodedObject, at: renderTime)
	}

	func renderDestinationImage(_ destinationImage: FxImageTile, sourceImages: [FxImageTile], pluginStateData: Data?, at renderTime: CMTime) throws {
		let decodedObject: PluginStateCodableData?
		if let pluginStateData {
			decodedObject = try pluginStateDecoder.decode(PluginStateCodableData.self, from: pluginStateData)
		} else {
			decodedObject = nil
		}

		try renderDestinationImage(destinationImage, sourceImages: sourceImages, pluginState: decodedObject, at: renderTime)
	}

	// optional stuff
	func finishInitialSetup() throws {}

	func pluginInstanceAddedToDocument() {}

	func createView(for parameter: ParameterID) -> NSView? { nil }
}
