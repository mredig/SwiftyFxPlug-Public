import Foundation

public typealias RawRGBColor = SIMD3<Double>
public typealias RawRGBAColor = SIMD4<Double>

public extension RawRGBColor {
	var red: Double { x }
	var green: Double { y }
	var blue: Double { z }

	init(red: Double, green: Double, blue: Double) {
		self.init(x: red, y: green, z: blue)
	}
}

public extension RawRGBAColor {
	var red: Double { x }
	var green: Double { y }
	var blue: Double { z }
	var alpha: Double { w }

	init(red: Double, green: Double, blue: Double, alpha: Double) {
		self.init(x: red, y: green, z: blue, w: alpha)
	}
}
