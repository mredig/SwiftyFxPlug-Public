import FxPlug

struct Light: Codable, Hashable {
	enum LightType: String, Codable, Hashable {
		case ambient
		case directional
		case point
		case spot

		var fxLightType: FxLightType {
			switch self {
			case .ambient:
				return UInt(kFxLightType_Ambient)
			case .directional:
				return UInt(kFxLightType_Directional)
			case .point:
				return UInt(kFxLightType_Point)
			case .spot:
				return UInt(kFxLightType_Spot)
			}
		}
	}
	let version: UInt
	let time: CMTime
	let lightType: LightType
	let color: SIMD3<Double>
	let intensity: Float
	let constantAttenuation: Float
	let linearAttenuation: Float
	let quadraticAttenuation: Float
	let castsShadows: Bool
	let spotCutoff: Float
	let spotPenumbraCutoff: Float
	let position: SIMD3<Double>
	let direction: SIMD3<Double>
}

extension Light {
	init(_ fxLight: FxLight) {
		self.lightType = {
			switch Int(fxLight.lightType) {
			case kFxLightType_Spot:
				return .spot
			case kFxLightType_Ambient:
				return .ambient
			case kFxLightType_Directional:
				return .directional
			default:
				return .point
			}
		}()
		self.color = {
			let color = fxLight.color?.takeUnretainedValue()
			var red: CGFloat = 0
			var green: CGFloat = 0
			var blue: CGFloat = 0
			color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
			return .init(red, green, blue)
		}()
		self.version = fxLight.version
		self.time = fxLight.time
		self.intensity = fxLight.intensity
		self.constantAttenuation = fxLight.constantAttenuation
		self.linearAttenuation = fxLight.linearAttenuation
		self.quadraticAttenuation = fxLight.quadraticAttenuation
		self.castsShadows = fxLight.castsShadows.boolValue
		self.spotCutoff = fxLight.spotCutoff
		self.spotPenumbraCutoff = fxLight.spotPenumbraCutoff
		self.position = .init(fxLight.position.x, fxLight.position.y, fxLight.position.z)
		self.direction = .init(fxLight.direction.x, fxLight.direction.y, fxLight.direction.z)
	}

	var fxLight: FxLight {
		FxLight(
			version: version,
			time: time,
			lightType: lightType.fxLightType,
			color: Unmanaged<NSColor>.passUnretained(.init(red: color.x, green: color.y, blue: color.z, alpha: 1)), // needs checking to confirm stability and no leak
			intensity: intensity,
			constantAttenuation: constantAttenuation,
			linearAttenuation: linearAttenuation,
			quadraticAttenuation: quadraticAttenuation,
			castsShadows: ObjCBool(booleanLiteral: castsShadows),
			spotCutoff: spotCutoff,
			spotPenumbraCutoff: spotPenumbraCutoff,
			position: FxPoint3D(x: position.x, y: position.y, z: position.z),
			direction: FxPoint3D(x: direction.x, y: direction.y, z: direction.z))
	}
}
