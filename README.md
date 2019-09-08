# JSTools

![JSTools Image](https://github.com/steelwheels/JSTools/blob/master/Document/images/JSTools-ScreenShot-1.png)

## Introduction
*JSTools* contains command line applications to execute JavaScript on the shell.
These applications are designed based on [Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy).

There are 3 kind of applications in this tools:
1. The command to execute JavaScript on the shell. The built-in library supports pipeline programming with the standard-input and standard-output.
2. The command to generate, expand and edit the JSON data stream. The usual data conversion can be done by these command without coding custom script.
3. The wrapper command to give options and arguments by JSON data instead of command line.
It generalized the syntax of option and argument for different commands.

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
### Command line applications
* [`jsh`](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md): JavaScript Shell, named `jsh`. The language to describe the script is [JavaScript-Shell](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).
* [`jscat`](https://github.com/steelwheels/JSTools/blob/master/Document/jscat-man.md): JSON file operation: Concatenate JSON files.
* [`jsgrep`](https://github.com/steelwheels/JSTools/blob/master/Document/jsgrep-man.md): Select part of object from input JSON file by matching of regular expression.
* [`jsadb`](https://github.com/steelwheels/JSTools/blob/master/Document/jsadb-man.md): Read, write and update AddressBook database.

## Related Links
* [Steel Wheels Project Web Page](http://steelwheels.github.io): Steel Wheels Project: Main Web Page

<hr/>
This project is managed by [OSDN](https://osdn.net/).
<a href="https://osdn.net/">
  <img src="https://osdn.net/sflogo.php?group_id=10809&type=1" width="96" height="29" border="0" alt="OSDN" />
</a>
