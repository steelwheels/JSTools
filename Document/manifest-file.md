# Manifest file

## Introduction
This document describes about *manifest file*.
The file defines the location of JavaScript files for an application.
The [jsh](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) command in [JSTools](https://github.com/steelwheels/JSTools) support this file.
The manifest file is put in the top directory in the `jspkg` bundle.

## File format
The manifest file defines the location of the files by JSON format.
````
{
        "application":  "<path for main JavaScript>",
         "libraries": [
                "<path for JavaScript library 0>",
                "<path for JavaScript library 1>",
                ...
        ],
        "scripts": {
                "script-name-0": "<path for JavaScript file0>",
                "script-name-1": "<path for JavaScript file1>",
                ...
        }
}
````

### Path for script file
The path for the script file is defined as *relative path* against the top package directory.

### `application` section
The path of JavaScript file to be executed first.

### `libraries` section
This is optional definition.
This section defines 1 or more library script files.
They will be parsed before executing application script.
If you use threads, these library files are also parsed before executing the thread script.

### `scripts` section
This is optional definition.
In usually, the script file is used to execute a thread.

# Related document
* [JSTools](https://github.com/steelwheels/JSTools): Command line JavaScript tools.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
