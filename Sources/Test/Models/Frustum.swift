import Foundation

struct Frustum: Codable, Hashable {
	let left: Double
	let right: Double
	let bottom: Double
	let top: Double
	let near: Double
	let far: Double

	var width: Double { right - left }
	var height: Double { top - bottom }

	var hFov: Angle { .radians(2 * atan(width / (2 * near))) }
	var vFov: Angle { .radians(2 * atan(height / (2 * near))) }

	init(left: Double, right: Double, bottom: Double, top: Double, near: Double, far: Double) {
		self.left = left
		self.right = right
		self.bottom = bottom
		self.top = top
		self.near = near
		self.far = far
	}
}
