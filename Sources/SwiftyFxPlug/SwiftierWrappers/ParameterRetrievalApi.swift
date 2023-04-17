import FxPlug

public struct ParameterRetrievalApi<ParameterID: UInt32Raw> {
	private let api: FxParameterRetrievalAPI_v7

	public init(api: FxParameterRetrievalAPI_v7) {
		self.api = api
	}

	public func boolValue(fromParameter parameter: ParameterID, at time: CMTime) throws -> Bool {
		var value = ObjCBool(false)
		let success = api.getBoolValue(&value, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return value.boolValue
	}

	public func customValue<T: NSCopying & NSSecureCoding & NSObjectProtocol>(
		fromParameter parameter: ParameterID,
		at time: CMTime) throws -> T {
			var temp: (any NSCopying & NSSecureCoding & NSObjectProtocol)! = nil
			let success = api.getCustomParameterValue(
				&temp,
				fromParameter: parameter.rawValue,
				at: time)
			guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
			return try (temp as? T).unwrap()
		}

	public func floatValue(fromParameter parameter: ParameterID, at time: CMTime) throws -> Double {
		var value: Double = 0
		let success = api.getFloatValue(&value, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return value
	}

	public func fontName(fromParameter parameter: ParameterID, at time: CMTime) throws -> String {
		var value: NSString = ""
		let success = api.getFontName(&value, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return value as String
	}

	public func gradientSamples(
		fromParameter parameter: ParameterID,
		numberOfSamples sampleCount: UInt,
		depth: ComponentDepth,
		at time: CMTime) throws -> Data {
			let byteCount = 4 * sampleCount * depth.rawValue
			let buffer = UnsafeMutableRawPointer.allocate(byteCount: Int(byteCount), alignment: 8)
			defer { buffer.deallocate() }
			let success = api.getGradientSamples(
				buffer,
				numSamples: sampleCount,
				depth: depth.rawValue,
				fromParameter: parameter.rawValue,
				at: time)
			guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
			let data = Data(bytes: buffer, count: Int(byteCount))
			return data
		}

	public func historgramInfo(fromParameter parameter: ParameterID, forChannel channel: HistogramChannel, at time: CMTime) throws -> HistorgramInfo {
		var (blackIn, blackOut, whiteIn, whiteOut, gamma) = (0.0, 0.0, 0.0, 0.0, 0.0)
		let success = api.getHistogramBlack(
			in: &blackIn,
			blackOut: &blackOut,
			whiteIn: &whiteIn,
			whiteOut: &whiteOut,
			gamma: &gamma,
			forChannel: channel.rawValue,
			fromParameter: parameter.rawValue,
			at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return HistorgramInfo(
			blackIn: blackIn,
			blackOut: blackOut,
			whiteIn: whiteIn,
			whiteOut: whiteOut,
			gamma: gamma)
	}

	public func intValue(fromParameter parameter: ParameterID, at time: CMTime) throws -> Int32 {
		var value: Int32 = 0
		let success = api.getIntValue(&value, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return value
	}

	public func parameterFlags(fromParameter parameter: ParameterID) throws -> ParameterFlag {
		var value: UInt32 = 0
		let success = api.getParameterFlags(&value, fromParameter: parameter.rawValue)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return ParameterFlag(rawValue: value)
	}

	public func pathID(fromParameter parameter: ParameterID, at time: CMTime) throws -> FxPathID {
		var pathID: UnsafeMutablePointer<FxPathID>?
		pathID = nil // silence warning
		let success = api.getPathID(pathID, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return try pathID.unwrap().pointee
	}

	public func rgbaValues(fromParameter parameter: ParameterID, at time: CMTime) throws -> RawRGBAColor {
		var (r, g, b, a) = (0.0, 0.0, 0.0, 0.0)
		let success = api.getRedValue(
			&r,
			greenValue: &g,
			blueValue: &b,
			alphaValue: &a,
			fromParameter: parameter.rawValue,
			at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return RawRGBAColor(red: r, green: g, blue: b, alpha: a)
	}

	public func rgbValues(fromParameter parameter: ParameterID, at time: CMTime) throws -> RawRGBColor {
		var (r, g, b) = (0.0, 0.0, 0.0)
		let success = api.getRedValue(
			&r,
			greenValue: &g,
			blueValue: &b,
			fromParameter: parameter.rawValue,
			at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return RawRGBColor(red: r, green: g, blue: b)
	}

	public func stringValue(fromParameter parameter: ParameterID) throws -> String {
		var value: NSString = ""
		let success = api.getStringParameterValue(&value, fromParameter: parameter.rawValue)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return value as String
	}

	public func location(fromParameter parameter: ParameterID, at time: CMTime) throws -> CGPoint {
		var (x, y) = (0.0, 0.0)
		let success = api.getXValue(&x, yValue: &y, fromParameter: parameter.rawValue, at: time)
		guard success else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return CGPoint(x: x, y: y)
	}

	public func imageSize(fromParameter parameter: ParameterID, at time: CMTime) throws -> CGSize {
		var size = CGSize(width: -1, height: -1)
		try api.imageSize(&size, fromParameter: parameter.rawValue, at: time)
		guard size != CGSize(width: -1, height: -1) else { throw ParameterRetrievalError.unsuccessfulRetrievalAttempt }
		return size
	}

	public enum ParameterRetrievalError: Error {
		case unsuccessfulRetrievalAttempt
	}
}
