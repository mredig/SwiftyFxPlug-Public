import Foundation

typealias RawRGBColor = SIMD3<Double>
typealias RawRGBAColor = SIMD4<Double>

extension RawRGBColor {
	var red: Double { x }
	var green: Double { y }
	var blue: Double { z }

	init(red: Double, green: Double, blue: Double) {
		self.init(x: red, y: green, z: blue)
	}
}

extension RawRGBAColor {
	var red: Double { x }
	var green: Double { y }
	var blue: Double { z }
	var alpha: Double { w }

	init(red: Double, green: Double, blue: Double, alpha: Double) {
		self.init(x: red, y: green, z: blue, w: alpha)
	}
}
