import FxPlug

enum HistogramChannel {
	case rgb
	case red
	case green
	case blue
	case alpha

	var rawValue: FxHistogramChannel {
		switch self {
		case .rgb:
			return UInt(kFxHistogramChannel_RGB)
		case .red:
			return UInt(kFxHistogramChannel_Red)
		case .green:
			return UInt(kFxHistogramChannel_Green)
		case .blue:
			return UInt(kFxHistogramChannel_Blue)
		case .alpha:
			return UInt(kFxHistogramChannel_Alpha)
		}
	}
}
