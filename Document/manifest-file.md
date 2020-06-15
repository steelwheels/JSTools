# Manifest file

## Introduction
This document describes about *manifest file*.
The file defines the location of JavaScript files for an application.
The [jsh](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) command in [JSTools](https://github.com/steelwheels/JSTools) support this file.
The manifest file is put in the top directory in the `jspkg` bundle.

## File format
The manifest file defines the location of the files by
[extended JSON](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Data/object-notation.md)
format.
````
{
         libraries: [
                "<path for JavaScript library 0>",
                "<path for JavaScript library 1>",
                ...
        ],
        scripts: {
                section-name-0: ["<path for JavaScript file0-0>",
                                   "<path for JavaScript file0-1>",
                                   ...],
                section-name-1: ["<path for JavaScript file1-0>",
                                   "<path for JavaScript file1-1>",
                                   ...],
                ...
        }
}
````

### Path for script file
The path for the script file is defined as *relative path* against the top package directory.

### `libraries` section
This is optional definition.
This section defines 1 or more library script files.
They will be parsed before compiling scripts in `scripts` section.
If you use threads, these library files are also parsed before executing the thread script.

### `scripts` section
This is required section.
Each threads will have independent items.
The section name `main` is used for main thread.

# Related document
* [extended JSON](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Data/object-notation.md): Extended JSON format to describe object as text
* [JSTools](https://github.com/steelwheels/JSTools): Command line JavaScript tools.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
