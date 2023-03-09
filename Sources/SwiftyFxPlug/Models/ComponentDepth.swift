import FxPlug

public enum ComponentDepth {
	case uint8
	case float16
	case float32

	public var rawValue: FxDepth {
		switch self {
		case .uint8:
			return UInt(kFxDepth_UINT8)
		case .float16:
			return UInt(kFxDepth_FLOAT16)
		case .float32:
			return UInt(kFxDepth_FLOAT32)
		}
	}

	public init?(rawValue: FxDepth) {
		switch rawValue {
		case UInt(kFxDepth_UINT8):
			self = .uint8
		case UInt(kFxDepth_FLOAT16):
			self = .float16
		case UInt(kFxDepth_FLOAT32):
			self = .float32
		default:
			return nil
		}
	}
}
