# JSTools

![JSTools Image](https://github.com/steelwheels/JSTools/blob/master/Document/images/JSTools-ScreenShot-1.png)

## Introduction
*JSTools* contains command line applications to execute JavaScript on the shell.
These applications are designed based on [Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy).

There are 2 kind of applications in this tools:
1. The command to execute JavaScript on the shell. The built-in library supports pipeline programming with the standard-input and standard-output.
2. The command to generate, expand and edit the JSON data stream. The usual data conversion can be done by these command without coding custom script.

The most important thing: This is open source product. You can add/improve libraries by yourself.

This tool uses *JavaScriptCore* in the [WebKit](https://en.wikipedia.org/wiki/WebKit) for macOS.

## Copyright
This software is produced by [Steel Wheels Project](http://steelwheels.github.io) and distributed under
[GNU GENERAL PUBLIC LICENSE Version 2.1](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html#SEC1). You can download the source code from the [repository on GitHub](https://github.com/steelwheels/JSRunner).

## Target
* OS: macOS High Sierra (10.13.2) or later

## Development environment
* Tool: Xcode 9 or later
* Programming language: Swift

## Download and Install
### Binary file
The binary package can be downloaded from [Open Source Developer Network](https://osdn.net) (OSDN). Visit [download page](https://osdn.net/projects/jstools/releases/).

### Build from the source
See [required software](https://github.com/steelwheels/JSTools/blob/master/Document/software.md) page.

## User's manual
* [`jsrun`](https://github.com/steelwheels/JSTools/blob/master/Document/jsrun-man.md): Execute JavaScript
* [`jscat`](https://github.com/steelwheels/JSTools/blob/master/Document/jscat-man.md): JSON file operation: Concatenate JSON files.
* [`jsgrep`](https://github.com/steelwheels/JSTools/blob/master/Document/jsgrep-man.md): Select part of object from input JSON file by matching of regular expression.
* [`jsadb`](https://github.com/steelwheels/JSTools/blob/master/Document/jsadb-man.md): Read, write and update AddressBook database.

## Programming manual
* [Require statement](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/RequireFunc.md): Require: JavaScript module manager
* [Built-in Modules](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Library.md): The list of built-in JavaScript modules which is embedded in `jsrun` command.

## Sample scripts
Some sample scripts are contained in the JSTool distribution package (and source core repository).
The file location is: `jstools.bundle/Contents/Resources/`.
There are some directories to categorize the software.
### Game
* [Game/Hanoi](https://github.com/steelwheels/JSTools/tree/master/Resource/Game/Hanoi): Source code to emulate Hanoi-Tower game.

## Reference manual
* [KiwiLibrary Framework](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/README.md): Library reference
* [Steel Wheels Project Web Page](http://steelwheels.github.io): Steel Wheels Project: Main Web Page
