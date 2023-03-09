import Foundation

public struct Angle: RawRepresentable {
	static public let degreesToRadians: Double = .pi / 180
	static public let radiansToDegress: Double = 180 / .pi

	public let rawValue: Double

	public var radians: Double { rawValue }
	public var degrees: Double { rawValue * Self.radiansToDegress }

	public init(rawValue: Double) {
		self.rawValue = rawValue
	}

	public init(radians: Double) {
		self.init(rawValue: radians)
	}

	public init(degrees: Double) {
		self.init(rawValue: degrees * (.pi / 180))
	}

	static public func radians(_ value: Double) -> Angle {
		Angle(radians: value)
	}

	static public func degrees(_ value: Double) -> Angle {
		Angle(degrees: value)
	}
}
