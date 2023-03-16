import FxPlug

public struct ParameterCreationApi<ParameterID: UInt32Raw> {
	private let api: FxParameterCreationAPI_v5

	public init(api: FxParameterCreationAPI_v5) {
		self.api = api
	}

	public func addAngleSlider(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: Angle,
		minDegrees: Angle,
		maxDegrees: Angle,
		parameterFlags: ParameterFlag) throws {
			let success = api.addAngleSlider(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultDegrees: defaultValue.degrees,
				parameterMinDegrees: minDegrees.degrees,
				parameterMaxDegrees: maxDegrees.degrees,
				parameterFlags: parameterFlags.rawValue)

			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addRGBColorParameter(
		withName name: String,
		parameterID: ParameterID,
		defaultColor: RawRGBColor,
		parameterFlags: ParameterFlag) throws {
			let success = api.addColorParameter(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultRed: defaultColor.red,
				defaultGreen: defaultColor.green,
				defaultBlue: defaultColor.blue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addRGBAColorParameter(
		withName name: String,
		parameterID: ParameterID,
		defaultColor: RawRGBAColor,
		parameterFlags: ParameterFlag) throws {
			let success = api.addColorParameter(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultRed: defaultColor.red,
				defaultGreen: defaultColor.green,
				defaultBlue: defaultColor.blue,
				defaultAlpha: defaultColor.alpha,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addCustomParameter<T: NSCopying & NSSecureCoding & NSObjectProtocol>(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: T,
		parameterFlags:	ParameterFlag) throws {
			let success = api.addCustomParameter(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: defaultValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addFloatSlider(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: Double,
		parameterRealRange: ClosedRange<Double>,
		sliderRange: ClosedRange<Double>,
		delta: Double,
		parameterFlags: ParameterFlag) throws {
			let success = api.addFloatSlider(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: defaultValue,
				parameterMin: parameterRealRange.lowerBound,
				parameterMax: parameterRealRange.upperBound,
				sliderMin: sliderRange.lowerBound,
				sliderMax: sliderRange.upperBound,
				delta: delta,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addFontMenu(
		withName name: String,
		parameterID: ParameterID,
		fontName: String,
		parameterFlags: ParameterFlag) throws {
			let success = api.addFontMenu(
				withName: name,
				parameterID: parameterID.rawValue,
				fontName: fontName,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addGradient(
		withName name: String,
		parameterID: ParameterID,
		parameterFlags: ParameterFlag) throws {
			let success = api.addGradient(
				withName: name,
				parameterID: parameterID.rawValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addHelpButton(
		withName name: String,
		parameterID: ParameterID,
		selector: Selector,
		parameterFlags: ParameterFlag) throws {
			let success = api.addHelpButton(
				withName: name,
				parameterID: parameterID.rawValue,
				selector: selector,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addHistogram(
		withName name: String,
		parameterID: ParameterID,
		parameterFlags: ParameterFlag) throws {
			let success = api.addHistogram(
				withName: name,
				parameterID: parameterID.rawValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addImageReference(
		withName name: String,
		parameterID: ParameterID,
		parameterFlags: ParameterFlag) throws {
			let success = api.addImageReference(
				withName: name,
				parameterID: parameterID.rawValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addIntSlider(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: Int32,
		parameterRealRange: ClosedRange<Int32>,
		sliderRange: ClosedRange<Int32>,
		delta: Int32,
		parameterFlags: ParameterFlag) throws {
			let success = api.addIntSlider(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: defaultValue,
				parameterMin: parameterRealRange.lowerBound,
				parameterMax: parameterRealRange.upperBound,
				sliderMin: sliderRange.lowerBound,
				sliderMax: sliderRange.upperBound,
				delta: delta,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addPathPicker(
		withName name: String,
		parameterID: ParameterID,
		parameterFlags: ParameterFlag) throws {
			let success = api.addPathPicker(
				withName: name,
				parameterID: parameterID.rawValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addPercentSlider(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: Double,
		parameterRealRange: ClosedRange<Double>,
		sliderRange: ClosedRange<Double>,
		delta: Double,
		parameterFlags: ParameterFlag) throws {
			let success = api.addPercentSlider(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: defaultValue,
				parameterMin: parameterRealRange.lowerBound,
				parameterMax: parameterRealRange.upperBound,
				sliderMin: sliderRange.lowerBound,
				sliderMax: sliderRange.upperBound,
				delta: delta,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addPointParameter(
		withName name: String,
		parameterID: ParameterID,
		defaultPoint: CGPoint,
		parameterFlags: ParameterFlag) throws {
			let success = api.addPointParameter(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultX: defaultPoint.x,
				defaultY: defaultPoint.y,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addPopupMenu<Option>(
		withName name: String,
		parameterID: ParameterID,
		options: PopupOptions<Option>,
		parameterFlags: ParameterFlag) throws {
			let success = api.addPopupMenu(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: UInt32(options.selectedIndex),
				menuEntries: options.options.map(\.localizedStringKey),
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addPushButton(
		withName name: String,
		parameterID: ParameterID,
		selector: Selector,
		parameterFlags: ParameterFlag) throws {
			let success = api.addPushButton(
				withName: name,
				parameterID: parameterID.rawValue,
				selector: selector,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addStringParameter(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: String,
		parameterFlags: ParameterFlag) throws {
			let success = api.addStringParameter(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: defaultValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addToggleButton(
		withName name: String,
		parameterID: ParameterID,
		defaultValue: Bool,
		parameterFlags: ParameterFlag) throws {
			let success = api.addToggleButton(
				withName: name,
				parameterID: parameterID.rawValue,
				defaultValue: defaultValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}

	public func addParameterSubgroup(
		withName name: String,
		withContents contents: () throws -> Void,
		parameterID: ParameterID,
		parameterFlags: ParameterFlag) throws {
			var success = api.startParameterSubGroup(
				name,
				parameterID: parameterID.rawValue,
				parameterFlags: parameterFlags.rawValue)
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }

			try contents()

			success = api.endParameterSubGroup()
			guard success else { throw ParameterCreationError.unsuccessfulCreationAttempt }
		}


	enum ParameterCreationError: Error {
		case unsuccessfulCreationAttempt
	}
}
