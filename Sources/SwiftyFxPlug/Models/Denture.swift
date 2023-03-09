import Foundation

/**
 Denture *retains* (get it?!) with some manual memory management because XPC or ViewBridge or FxPlug is touchy with something. These get released when the plugin
 is closed (similar to how it works in the simple color corrector example

 Used to cache a copy of custom views presented by VIewBridge
 */
class Denture<T: AnyObject> {
	private var store: Unmanaged<T>?

	func storeItem(_ item: T) {
		store = .passRetained(item)
	}

	func retrieveItem() -> T? {
		store?.takeUnretainedValue()
	}
}
