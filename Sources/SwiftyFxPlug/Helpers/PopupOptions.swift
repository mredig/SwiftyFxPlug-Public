import Foundation

public struct PopupOptions<Option: LocalizedStringKeyProvider> {
	public let options: [Option]
	private var _selectedIndex: Int
	public var selectedIndex: Int {
		get { _selectedIndex }
		set {
			guard
				options.indices.contains(newValue)
			else { return }
			_selectedIndex = newValue
		}
	}

	public init(options: [Option], selectedIndex: Int) {
		guard
			options.indices.contains(selectedIndex)
		else { fatalError("Index \(selectedIndex) out of range for \(type(of: [Option].self))")}
		self.options = options
		self._selectedIndex = selectedIndex
	}
}

public extension PopupOptions where Option: CaseIterable {
	init(selectedIndex: Int = 0) {
		let cases = Option.allCases
		guard cases.isEmpty == false else { fatalError("\(type(of: Option.self)) must have some cases!") }
		self.options = Array(cases)
		self._selectedIndex = selectedIndex
	}
}
