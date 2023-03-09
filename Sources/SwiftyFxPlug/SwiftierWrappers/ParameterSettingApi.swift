import FxPlug

struct ParameterSettingApi<ParameterID: UInt32Raw> {
	private let api: FxParameterSettingAPI_v6

	init(api: FxParameterSettingAPI_v6) {
		self.api = api
	}

	func setBoolValue(_ value: Bool, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setBoolValue(value, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setCustomParameterValue<T: NSCopying & NSSecureCoding & NSObjectProtocol>(_ value: T, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setCustomParameterValue(value, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setFloatValue(_ value: any BinaryFloatingPoint, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setFloatValue(Double(value), toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setFloatValue(_ value: Double, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setFloatValue(value, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setHistogram(blackIn: Double, blackOut: Double, whiteIn: Double, whiteOut: Double, gamma: Double, forChannel channel: ColorChannel, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setHistogramBlackIn(blackIn, blackOut: blackOut, whiteIn: whiteIn, whiteOut: whiteOut, gamma: gamma, forChannel: channel.rawValue, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setIntValue(_ value: any BinaryInteger, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setIntValue(Int32(value), toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setParameterFlags(_ flags: ParameterFlag, toParameter parameter: ParameterID) throws {
		let success = api.setParameterFlags(flags.rawValue, toParameter: parameter.rawValue)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func addFlags(_ flags: ParameterFlag, toParameter parameter: ParameterID) throws {
		let success = api.addFlags(flags.rawValue, toParameter: parameter.rawValue)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func removeFlags(_ flags: ParameterFlag, toParameter parameter: ParameterID) throws {
		let success = api.removeFlags(flags.rawValue, fromParameter: parameter.rawValue)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setPathID(_ value: FxPathID, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setPathID(value, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setColorValue(_ value: SIMD3<Double>, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setRedValue(value.x, greenValue: value.y, blueValue: value.z, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setColorValue(_ value: SIMD4<Double>, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setRedValue(value.x, greenValue: value.y, blueValue: value.z, alphaValue: value.w, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setStringValue(_ value: String, toParameter parameter: ParameterID) throws {
		let success = api.setStringParameterValue(value, toParameter: parameter.rawValue)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	func setPoint(_ value: CGPoint, toParameter parameter: ParameterID, at time: CMTime) throws {
		try setXValue(value.x, yValue: value.y, toParameter: parameter, at: time)
	}

	func setXValue(_ xValue: Double, yValue: Double, toParameter parameter: ParameterID, at time: CMTime) throws {
		let success = api.setXValue(xValue, yValue: yValue, toParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterSettingError.unsuccessfulSettingAttempt }
	}

	enum ParameterSettingError: Error {
		case unsuccessfulSettingAttempt
	}
}
