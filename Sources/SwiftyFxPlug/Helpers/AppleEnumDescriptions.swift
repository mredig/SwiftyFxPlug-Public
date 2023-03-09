import FxPlug

// A collection of enum descriptions for convenience when printing to the console

extension CGImageByteOrderInfo: CustomDebugStringConvertible {
	public var debugDescription: String {
		switch self {
		case .orderMask:
			return "CGImageByteOrderInfo.orderMask"
		case .orderDefault:
			return "CGImageByteOrderInfo.orderDefault"
		case .order16Little:
			return "CGImageByteOrderInfo.order16Little"
		case .order32Little:
			return "CGImageByteOrderInfo.order32Little"
		case .order16Big:
			return "CGImageByteOrderInfo.order16Big"
		case .order32Big:
			return "CGImageByteOrderInfo.order32Big"
		@unknown default:
			return "CGImageByteOrderInfo.unknown enumeration! Raw value: \(rawValue)"
		}
	}
}

extension CGImagePixelFormatInfo: CustomDebugStringConvertible {
	public var debugDescription: String {
		switch self {
		case .RGB101010:
			return "CGImagePixelFormatInfo.RGB101010"
		case .RGB555:
			return "CGImagePixelFormatInfo.RGB555"
		case .RGB565:
			return "CGImagePixelFormatInfo.RGB565"
		case .RGBCIF10:
			return "CGImagePixelFormatInfo.RGBCIF10"
		case .mask:
			return "CGImagePixelFormatInfo.mask"
		case .packed:
			return "CGImagePixelFormatInfo.packed"
		@unknown default:
			return "CGImagePixelFormatInfo.unknown enumeration! Raw value: \(rawValue)"
		}
	}
}
