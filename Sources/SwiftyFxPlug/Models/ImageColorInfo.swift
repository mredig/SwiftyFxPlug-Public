import FxPlug

public enum ImageColorInfo {
	case rgbLinear
	case rgbGammaVideo

	var rawValue: FxImageColorInfo {
		switch self {
		case .rgbLinear:
			return UInt(kFxImageColorInfo_RGB_LINEAR)
		case .rgbGammaVideo:
			return UInt(kFxImageColorInfo_RGB_GAMMA_VIDEO)
		}
	}

	init?(rawValue: FxImageColorInfo) {
		switch rawValue {
		case UInt(kFxImageColorInfo_RGB_LINEAR):
			self = .rgbLinear
		case UInt(kFxImageColorInfo_RGB_GAMMA_VIDEO):
			self = .rgbGammaVideo
		default:
			return nil
		}
	}
}
