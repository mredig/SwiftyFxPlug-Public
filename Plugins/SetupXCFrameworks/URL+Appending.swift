//
//  File.swift
//  
//
//  Created by Michael Redig on 3/9/23.
//

import Foundation

extension URL {
	func appendingComponent(_ component: String, withExtension ext: String?, isDirectory: Bool? = nil) -> URL {
		let base: URL
		if #available(macOS 13.0, *) {
			if let isDirectory {
				base = self.appending(component: component, directoryHint: isDirectory ? .isDirectory : .notDirectory)
			} else {
				base = self.appending(component: component, directoryHint: .inferFromPath)
			}
		} else {
			if let isDirectory {
				base = self.appendingPathComponent(component, isDirectory: isDirectory)
			} else {
				base = self.appendingPathComponent(component)
			}
		}

		if let ext {
			return base.appendingPathExtension(ext)
		} else {
			return base
		}
	}
}
