# JSTools: JavaScript for shell scripting

![JSTools Image](https://github.com/steelwheels/JSTools/blob/master/Document/images/JSTools-ScreenShot-1.png)

## Introduction
*JSTools* provides command line applications for shell scripting.
The [jsh](#jsh) is a shell program based on the JavaScript. [jscat](#jscat), [jsgrep](#jsgrep), [jsadb](#jsadb) is similar to usual unix commands but it operate [JSON data](https://www.json.org) instead of plain text file.

## Copyright
This software is produced by [Steel Wheels Project](http://steelwheels.github.io). The software is distributed under
[GNU GENERAL PUBLIC LICENSE Version 2.1](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html#SEC1) and the document is [GNU Free Documentation License](https://www.gnu.org/licenses/fdl-1.3.en.html).

## Target
* OS: macOS 10.15 or later
* Development tool: Xcode 11.0 or later
* Programming language: Swift

## Application software
### jsh
The shell program based on JavaScript. The programming language which extend JavaScript for shell scripting is also called `jsh`.
About the the command and language, see [manual page](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) and [language specification](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).

### jscat
[`jscat`](https://github.com/steelwheels/JSTools/blob/master/Document/jscat-man.md) is used to concatenate JSON data files.

### jsgrep
[`jsgrep`](https://github.com/steelwheels/JSTools/blob/master/Document/jsgrep-man.md) selects part of object from input JSON file by matching of regular expression.

### jsadb
[`jsadb`](https://github.com/steelwheels/JSTools/blob/master/Document/jsadb-man.md) reads, writes and updates the AddressBook database.

## Frameworks/Libraries
Following software is used to build this package:
* [JSTools](https://github.com/steelwheels/JSTools): Main application software.
* [KiwiScript Framework](https://github.com/steelwheels/KiwiScript): Support JavaScript and Shell
* [Coconut Framework](https://github.com/steelwheels/Coconut): Define general purpose data structure
* [Cobalt](https://github.com/steelwheels/Cobalt): Command line parser

## Misc
### UTI definitions
* [.jspkg](https://github.com/steelwheels/JSTools/blob/master/Document/UTI-jspkg.txt): JavaScript package files


## Related Links
* [Steel Wheels Project Web Page](http://steelwheels.github.io): Steel Wheels Project: Main Web Page
