import Foundation

extension Optional {
	func unwrap() throws -> Wrapped {
		switch self {
		case .none:
			throw OptionalError.noneValue
		case .some(let wrapped):
			return wrapped
		}
	}

	enum OptionalError: Error {
		case noneValue
	}
}
