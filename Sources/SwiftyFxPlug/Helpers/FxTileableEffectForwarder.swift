import FxPlug

/**
This class is the objective c exposed variant of an FxTileableEffect. It is still needed since FxPlug uses the older Objective C style of class instantiation, so all this does
 is get initialized by the FxPlug XPC call, then forward all its calls to the Swift protocol, `SwiftyFxTileableEffectProtocol`, where things take a Swifty turn.
 You should be able to ignore this class, save for any additional features you may want to add to this library.
 */
@objc(FxTileableEffectForwarder) class FxTileableEffectForwarder: NSObject, FxTileableEffect, FxCustomParameterViewHost_v2 {
	let swiftyFxTileableEffect: any SwiftyFxTileableEffectProtocol

    required init?(apiManager: PROAPIAccessing) {
		self.swiftyFxTileableEffect = EffectFactory.createPluginInstance(apiManager)
    }

	func finishInitialSetup() throws {
		try swiftyFxTileableEffect.finishInitialSetup()
	}

	func pluginInstanceAddedToDocument() {
		swiftyFxTileableEffect.pluginInstanceAddedToDocument()
	}

	func properties(_ properties: AutoreleasingUnsafeMutablePointer<NSDictionary>?) throws {
		properties?.pointee = try swiftyFxTileableEffect.pluginProperties().nsDictionary
	}

	func addParameters() throws {
		try swiftyFxTileableEffect.addParameters()
	}

	func parameterChanged(_ paramID: UInt32, at time: CMTime) throws {
		try swiftyFxTileableEffect.parameterChangedRaw(paramID, at: time)
	}

	func pluginState(_ pluginState: AutoreleasingUnsafeMutablePointer<NSData>?, at renderTime: CMTime, quality qualityLevel: UInt) throws {
		pluginState?.pointee = try swiftyFxTileableEffect.pluginStateData(at: renderTime, qualityLevel: qualityLevel) as NSData
	}

	func destinationImageRect(_ destinationImageRect: UnsafeMutablePointer<FxRect>, sourceImages: [FxImageTile], destinationImage: FxImageTile, pluginState: Data?, at renderTime: CMTime) throws {
		destinationImageRect.pointee = try swiftyFxTileableEffect.destinationImageRect(sourceImages: sourceImages, destinationImage: destinationImage, pluginStateData: pluginState, at: renderTime)
	}

	func sourceTileRect(_ sourceTileRect: UnsafeMutablePointer<FxRect>, sourceImageIndex: UInt, sourceImages: [FxImageTile], destinationTileRect: FxRect, destinationImage: FxImageTile, pluginState: Data?, at renderTime: CMTime) throws {
		sourceTileRect.pointee = try swiftyFxTileableEffect.sourceTileRect(sourceImageIndex: sourceImageIndex, sourceImages: sourceImages, destinationTileRect: destinationTileRect, destinationImage: destinationImage, pluginStateData: pluginState, at: renderTime)
	}
    
	func renderDestinationImage(_ destinationImage: FxImageTile, sourceImages: [FxImageTile], pluginState: Data?, at renderTime: CMTime) throws {
		try swiftyFxTileableEffect.renderDestinationImage(destinationImage, sourceImages: sourceImages, pluginStateData: pluginState, at: renderTime)
	}

	func createView(forParameterID parameterID: UInt32) -> NSView! {
		swiftyFxTileableEffect.createViewRaw(for: parameterID)
	}

	override func responds(to aSelector: Selector!) -> Bool {
		guard super.responds(to: aSelector) == false else {
			return true
		}

		let responds = (swiftyFxTileableEffect as? NSObjectProtocol)?.responds(to: aSelector) ?? false
		return responds
	}

	override func forwardingTarget(for aSelector: Selector!) -> Any? {
		swiftyFxTileableEffect
	}
}
