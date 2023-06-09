# FxPlugSPM

Swiftier FxPlug usage.

## Getting started
After [adding this package to your project](#Note), create a class that conforms to `SwiftyFxTileableEffectProtocol` and in your FxPlug main.swift file, invoke the static method on your new class `MyClass.registerWithFactory()`. Finally, in your Info.plist, update `className` under `ProPlugInList` to `FxTileableEffectForwarder`.


### Note
This package cannot be directly added via Xcode's package manager and needs to be cloned in a nearby directory to your project.

1. Clone this project
	* best practice would be to locate this project directly beside your FxPlug project, so it can be standardized between you and anyone else working on the project
1. In your plugin project, right click on the project title in the navigator and select "Add Files..."
1. Choose this package and add to your project
1. (optional, but highly recommended) Edit your main project README or something to note the usage of this package and link to it so future you and anyone else using your project don't lose the reference to this project
1. Right click on SwiftyFxPlug and choose the `SetupXCFrameworks` plugin under the `SwiftyFxPlug` header. Grant any permissions necessary as it just configures the FxPlug SDK as xcframeworks, allowing direct usage through this package.
	* THIS is the reason adding directly via the xcode spm support doesn't work! Plugins apparently can only run on *editable* SPM packages, and when you add via the xcode interface, they are considered read only (or at least, that's the only reason I can figure.)
	* I cannot (both morally and probably legally) distribute the FxPlug sdk directly, which would on a technical level overcome this issue, but I refuse to compromise or risk that.
