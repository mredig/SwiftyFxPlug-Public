import FxPlug

public struct RemoteWindowApi {
	private let api: FxRemoteWindowAPI_v2
	private weak var apiAccessor: PROAPIAccessing?

	public typealias ViewResultBlock = (Result<NSView, Error>) -> Void

	public init(api: FxRemoteWindowAPI_v2) {
		self.api = api
	}

	public func remoteWindow(withMinimumSize minSize: CGSize, maxSize: CGSize, reply: @escaping ViewResultBlock) {
		api.remoteWindow(withMinimumSize: minSize, maximumSize: maxSize) { view, error in
			if let error {
				reply(.failure(error))
			}
			do {
				let view = try view.unwrap()
				reply(.success(view))
			} catch {
				reply(.failure(error))
			}
		}
	}

	public func remoteWindow(withMinimumSize minSize: CGSize, maxSize: CGSize) async throws -> NSView {
		try await api.remoteWindow(withMinimumSize: minSize, maximumSize: maxSize).unwrap()
	}

	public func remoteWindow(ofSize size: CGSize, reply: @escaping ViewResultBlock) {
		api.remoteWindow(of: size) { view, error in
			if let error {
				reply(.failure(error))
			}
			do {
				let view = try view.unwrap()
				reply(.success(view))
			} catch {
				reply(.failure(error))
			}
		}
	}

	public func remoteWindow(ofSize size: CGSize) async throws -> NSView {
		try await api.remoteWindow(of: size).unwrap()
	}
}
