# JavaScript package (.jspkg)

## Introduction
JavaScript package is a bundle of files for a JavaScript application.
The package can have multiple scripts, libraries and the other files.

## Structure
The top structure is a directory with `.jspkg` extension. You have to put the manifest file named `manifest.json` under the top directory to define the location of scripts.

The manifest file defines the reference of the other files for each sections. Now, the following sections are defined:
* application
* libraries
* threads

Here is a sample description of manifest file.
````
{
	"application": 		"main.js",
	"view":				"main.amb",
	"libraries": [
		"lib_a.js",
		"lib_b.js"
	],
	"threads": {
		"thread_a":	"thread_a.js",
		"thread_b":	"thread_b.js"
	},
	"subviews": {
		"subview_a": "subview_a.amb",
		"subview_b": "subview_b.amb"
	},
	"images": {
		"image_a": "image_a.jpg",
		"image_b": "image_b.png"
	}
}
````

### Application section
The item has the file name of the main script.
The main script must contain `main` function
(See [main function definition](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) for `jsh` command) .
This definition is _always required_.

### View section
The item has the file name of the component script.
See [Component libraries](https://github.com/steelwheels/KiwiCompnents/blob/master/Document/Library.md) about components.

### Libraries section
This `libraries` section contains array of library script files.
They will be compiled before compiling the application script and thread script.
The evaluation order is defined as the order of the array declaration.

### Threads section
The `threads` section contains some script files to execute as threads.
You can allocate thread in the main process (or the other threads) by the [thread function](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Function/Thread.md). The name is referred as thread name and the value is referred as script file name.

### Subviews section
The `subviews` section contains file names of the subview.

### Images section
The `images` section contains file names of image data.

# Implementation
The parser of manifest file is implement in [KiwiEngine](https://github.com/steelwheels/KiwiScript/tree/master/KiwiEngine) framework. See [KEManifest.swift](https://github.com/steelwheels/KiwiScript/blob/master/KiwiEngine/Source/KEManifest.swift).

# Related document
* [README](https://github.com/steelwheels/JSTools/blob/master/README.md): Summary of this repository
* [Object notation](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Data/object-notation.md): The syntax rule for this package description.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
