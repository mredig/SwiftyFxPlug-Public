import Foundation

enum FileContent {
	static let fxPlugSDKRemoveText = """
 #import <PluginManager/PROAPIAccessing.h>
 #import <PluginManager/PROPlugInBundleRegistration.h>
 """

	static let fxPlugSDKReplaceText = "#import <PluginManager/PluginManagerSDK.h>"

	static let pluginManagerHeaderContents = """
#import <PluginManager/PROAPIAccessing.h>
#import <PluginManager/PROPlugInBundleRegistration.h>
#import <PluginManager/PROPlugProtocols.h>

"""

	static func moduleMapFileContents(forFrameworkTitled frameworkTitle: String) -> String {
"""
framework module \(frameworkTitle) {
  umbrella header "\(frameworkTitle)SDK.h"

  export *
  module * { export * }
}

module \(frameworkTitle).Swift {
  header "\(frameworkTitle)-Swift.h"
  requires objc
}

"""
	}
}
