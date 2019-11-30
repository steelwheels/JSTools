

# JavaScript package (.jspkg)

## Introduction
JavaScript package is a bundle of files for a JavaScript application. The JavaScript shell, [jsh](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) can execute the application.

## Structure
The top structure is a directory with `.jspkg` extension. You have to put `manifest.json` under the top directory.
You can define multi scripts, library in the package.
The `manifest.json` file defines the location of scripts.

Here is a sample description of manifest file:
````
{
	"scripts": {
		"main": [
			"main.js"
		],
		"thread0": [
			"thread0.js"
		]
	}
}

````

### `scripts` section
This section contains some kind of script files.

#### `libraries` script section
This section contains some library script files.
They will be compiled before compiling the `main` script or thread script.

#### `main` script section
This section contains some script files for main program.

#### thread script section
This section contains some script files to execute threads.
You can allocate thread in the main process (or the other threads) by the [thread function](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Function/Thread.md). The section name is used to specify which thread is executed.


# Related document
* [README](https://github.com/steelwheels/JSTools/blob/master/README.md): Summary of this repository
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
