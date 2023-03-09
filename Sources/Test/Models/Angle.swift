import Foundation

struct Angle: RawRepresentable {
	static let degreesToRadians: Double = .pi / 180
	static let radiansToDegress: Double = 180 / .pi

	let rawValue: Double

	var radians: Double { rawValue }
	var degrees: Double { rawValue * Self.radiansToDegress }

	init(rawValue: Double) {
		self.rawValue = rawValue
	}

	init(radians: Double) {
		self.init(rawValue: radians)
	}

	init(degrees: Double) {
		self.init(rawValue: degrees * (.pi / 180))
	}

	static func radians(_ value: Double) -> Angle {
		Angle(radians: value)
	}

	static func degrees(_ value: Double) -> Angle {
		Angle(degrees: value)
	}
}
