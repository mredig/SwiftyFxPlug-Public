import FxPlug

enum EffectFactory {
	static var createPluginInstanceBlock: (PROAPIAccessing) -> any SwiftyFxTileableEffectProtocol = { _ in fatalError("Make sure to add `ConcreteSFXPImplementation.registerWithFactory` in main.swift BEFORE the XPC service starts!") }

	static func createPluginInstance(_ api: PROAPIAccessing) -> any SwiftyFxTileableEffectProtocol { createPluginInstanceBlock(api) }
}
