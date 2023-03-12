import FxPlug

public struct CustomAPI {
	private let api: FxCustomParameterActionAPI_v4
	private weak var apiAccessor: PROAPIAccessing?

	public init(api: FxCustomParameterActionAPI_v4, apiAccessor: PROAPIAccessing) {
		self.api = api
		self.apiAccessor = apiAccessor
	}

	public func startAction(_ sender: Any? = nil) {
		api.startAction(sender)
	}

	public func endAction(_ sender: Any? = nil) {
		api.endAction(sender)
	}

	public func runAction<T>(_ sender: Any? = nil, _ block: (PROAPIAccessing) throws -> T) throws -> T {
		api.startAction(sender)
		let apiAccessor = try self.apiAccessor.unwrap()
		let result = try block(apiAccessor)
		api.endAction(sender)
		return result
	}
}
