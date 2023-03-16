import Foundation

public enum LocalizationHelper {
	public static var bundleLocalizationPriority: [Bundle] = [.main]

	public static func localizedString(forKey key: String) -> String {
		for bundle in bundleLocalizationPriority {
			let value = bundle.localizedString(forKey: key)
			guard value != key else { continue }
			return value
		}
		return key
	}

	public static func localizedString(forKey key: String, in bundle: Bundle) -> String {
		bundle.localizedString(forKey: key)
	}
}

public protocol LocalizedStringKeyProvider {
	var localizedStringKey: String { get }
}

public extension LocalizedStringKeyProvider {
	var localizedStringValue: String {
		LocalizationHelper.localizedString(forKey: localizedStringKey)
	}
}

public extension Bundle {
	func localizedString(forKey key: String) -> String {
		localizedString(forKey: key, value: nil, table: nil)
	}
}

extension String: LocalizedStringKeyProvider {
	public var localizedStringKey: String { self }
}
