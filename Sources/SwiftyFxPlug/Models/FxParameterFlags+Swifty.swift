import FxPlug

public struct ParameterFlag: OptionSet {
	public var rawValue: UInt32

	static public let `default` = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DEFAULT))
	static public let notAnimatable = ParameterFlag(rawValue: UInt32(kFxParameterFlag_NOT_ANIMATABLE))
	static public let hidden = ParameterFlag(rawValue: UInt32(kFxParameterFlag_HIDDEN))
	static public let disabled = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DISABLED))
	static public let collapsed = ParameterFlag(rawValue: UInt32(kFxParameterFlag_COLLAPSED))
	static public let dontSave = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DONT_SAVE))
	static public let dontDisplayInDashboard = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DONT_DISPLAY_IN_DASHBOARD))
	static public let customUI = ParameterFlag(rawValue: UInt32(kFxParameterFlag_CUSTOM_UI))
	static public let ignoreMinmax = ParameterFlag(rawValue: UInt32(kFxParameterFlag_IGNORE_MINMAX))
	static public let curveEditorHidden = ParameterFlag(rawValue: UInt32(kFxParameterFlag_CURVE_EDITOR_HIDDEN))
	static public let dontRemapColors = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DONT_REMAP_COLORS))
	static public let useFullViewWidth = ParameterFlag(rawValue: UInt32(kFxParameterFlag_USE_FULL_VIEW_WIDTH))

	public init(rawValue: UInt32) {
		self.rawValue = rawValue
	}
}
