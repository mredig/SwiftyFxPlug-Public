import FxPlug

extension FxLightingAPI_v3 {
	func sceneLights(at time: CMTime) throws -> [FxLight] {
		let lightCount = numberOfLights(at: time)

		let lights: [FxLight] = try (0..<lightCount)
			.compactMap {
				var light = FxLight()
				try lightInfo(&light, forLight: $0, at: time)
				return light
			}
		return lights
	}
}
