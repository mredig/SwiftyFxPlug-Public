import FxPlug

struct ParameterFlag: OptionSet {
	var rawValue: UInt32

	static let `default` = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DEFAULT))
	static let notAnimatable = ParameterFlag(rawValue: UInt32(kFxParameterFlag_NOT_ANIMATABLE))
	static let hidden = ParameterFlag(rawValue: UInt32(kFxParameterFlag_HIDDEN))
	static let disabled = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DISABLED))
	static let collapsed = ParameterFlag(rawValue: UInt32(kFxParameterFlag_COLLAPSED))
	static let dontSave = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DONT_SAVE))
	static let dontDisplayInDashboard = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DONT_DISPLAY_IN_DASHBOARD))
	static let customUI = ParameterFlag(rawValue: UInt32(kFxParameterFlag_CUSTOM_UI))
	static let ignoreMinmax = ParameterFlag(rawValue: UInt32(kFxParameterFlag_IGNORE_MINMAX))
	static let curveEditorHidden = ParameterFlag(rawValue: UInt32(kFxParameterFlag_CURVE_EDITOR_HIDDEN))
	static let dontRemapColors = ParameterFlag(rawValue: UInt32(kFxParameterFlag_DONT_REMAP_COLORS))
	static let useFullViewWidth = ParameterFlag(rawValue: UInt32(kFxParameterFlag_USE_FULL_VIEW_WIDTH))

	init(rawValue: UInt32) {
		self.rawValue = rawValue
	}
}
