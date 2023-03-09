import FxPlug

public struct PluginPropertyConfiguration {
	public var variesWhenParamsAreStatic: Bool?
	public var preservesAlpha: Bool?
	public var pixelIndependent: Bool?
	public var isThreadSafe: Bool?
	public var mayRemapTime: Bool?
	public var usesLumaChroma: Bool?
	public var needsFullBuffer: Bool?
	public var usesRationalTime: Bool?
	public var changesOutputSize: Bool?
	public var drawsInScreenSpace: Bool?
	public var desiredProcessingColorInfo: ImageColorInfo?
	public var usesNonmatchingTextureLayout: Bool?
	public var userDefined: [String: NSNumber] = [:]

	var swiftDictionary: [String: NSNumber] {
		var dict: [String: NSNumber] = [:]

		if let variesWhenParamsAreStatic {
			dict[kFxPropertyKey_VariesWhenParamsAreStatic] = NSNumber(booleanLiteral: variesWhenParamsAreStatic)
		}
		if let preservesAlpha {
			dict[kFxPropertyKey_PreservesAlpha] = NSNumber(booleanLiteral: preservesAlpha)
		}
		if let pixelIndependent {
			dict[kFxPropertyKey_PixelIndependent] = NSNumber(booleanLiteral: pixelIndependent)
		}
		if let isThreadSafe {
			dict[kFxPropertyKey_IsThreadSafe] = NSNumber(booleanLiteral: isThreadSafe)
		}
		if let mayRemapTime {
			dict[kFxPropertyKey_MayRemapTime] = NSNumber(booleanLiteral: mayRemapTime)
		}
		if let usesLumaChroma {
			dict[kFxPropertyKey_UsesLumaChroma] = NSNumber(booleanLiteral: usesLumaChroma)
		}
		if let needsFullBuffer {
			dict[kFxPropertyKey_NeedsFullBuffer] = NSNumber(booleanLiteral: needsFullBuffer)
		}
		if let usesRationalTime {
			dict[kFxPropertyKey_UsesRationalTime] = NSNumber(booleanLiteral: usesRationalTime)
		}
		if let changesOutputSize {
			dict[kFxPropertyKey_ChangesOutputSize] = NSNumber(booleanLiteral: changesOutputSize)
		}
		if let drawsInScreenSpace {
			dict[kFxPropertyKey_DrawsInScreenSpace] = NSNumber(booleanLiteral: drawsInScreenSpace)
		}
		if let desiredProcessingColorInfo {
			dict[kFxPropertyKey_DesiredProcessingColorInfo] = NSNumber(integerLiteral: Int(desiredProcessingColorInfo.rawValue))
		}
		if let usesNonmatchingTextureLayout {
			dict[kFxPropertyKey_UsesNonmatchingTextureLayout] = NSNumber(booleanLiteral: usesNonmatchingTextureLayout)
		}
		dict = userDefined.reduce(into: dict, {
			$0[$1.key] = $1.value
		})

		return dict
	}

	var nsDictionary: NSDictionary {
		NSDictionary(dictionary: swiftDictionary)
	}
}
