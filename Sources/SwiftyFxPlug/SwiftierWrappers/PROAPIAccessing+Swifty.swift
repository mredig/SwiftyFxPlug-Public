import FxPlug

public extension PROAPIAccessing {
	func settingApi<ParameterID: UInt32Raw>(idType: ParameterID.Type) throws -> ParameterSettingApi<ParameterID> {
		guard
			let paramAPI = api(for: FxParameterSettingAPI_v6.self) as? FxParameterSettingAPI_v6
		else { throw PROAPIAccessingError.requestedApiNotAvailable }
		return ParameterSettingApi(api: paramAPI)
	}

	func creationApi<ParameterID: UInt32Raw>(idType: ParameterID.Type) throws -> ParameterCreationApi<ParameterID> {
		guard
			let paramAPI = api(for: FxParameterCreationAPI_v5.self) as? FxParameterCreationAPI_v5
		else { throw PROAPIAccessingError.requestedApiNotAvailable }
		return ParameterCreationApi(api: paramAPI)
	}

	func retrievalApi<ParameterID: UInt32Raw>(idType: ParameterID.Type) throws -> ParameterRetrievalApi<ParameterID> {
		guard
			let paramAPI = api(for: FxParameterRetrievalAPI_v7.self) as? FxParameterRetrievalAPI_v7
		else { throw PROAPIAccessingError.requestedApiNotAvailable }
		return ParameterRetrievalApi(api: paramAPI)
	}

	func customApi<ParameterID: UInt32Raw>(idType: ParameterID.Type) throws -> CustomAPI<ParameterID> {
		guard
			let customApi = api(for: FxCustomParameterActionAPI_v4.self) as? FxCustomParameterActionAPI_v4
		else { throw PROAPIAccessingError.requestedApiNotAvailable }
		return CustomAPI(api: customApi, apiAccessor: self)
	}
}

public enum PROAPIAccessingError: Error {
	case requestedApiNotAvailable
}
