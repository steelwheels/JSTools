# jsh: System Reference Manual

## Introduction
 The `jsh` is extended JavaScript to make shell scripting easier. It is supported by [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/README.md) and [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md).

This document describes about programming environment of `jsh`. There are many built-in libraries, functions and global variables. And this document does not describe about language syntax. If you want know about it, see [jsh language](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).

## Contents
* [Job control](#Job_Control)
* [Boot](#Boot)
* [Environment](#Environment)

## Job control
### Mode Switching
There are input mode on terminal.
The mode can be distinguished by the prompt character.

|Character      |Mode           |Description                    |
|:--            |:--            |:--                            |
|`>`            |Shell mode     |Accept shell command           |
|`%`            |Script mode    |Accept JavaScript              |

And the script mode accepts JavaScript code.
You can switch these mode by `'>'` and `'%'`.

![Two modes](images/mode2.png)

### Stop the process
* _For JSTerminal_: You can stop the process by pressing CTRL-C key.
* _For jsh commandline_: You can stop the process in the current window by choosing
_Stop menu item_ at Edit menu or pressing COMMAND-. key (`period` key + `command` key).

## Boot
### Run command file
If you put `.jshrc` JavScript file on your home directory, the file is parsed at the boot time (before outputting 1st prompt).

This file is used to customize the shell setting. The [Preference](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/Preference.md) object supports to setup custom parameters for the shell.
Even if you want to common library for your application, do not define in this file. Use [JavaScript package (`.jspkg`)](https://github.com/steelwheels/JSTools/blob/master/Document/jspkg.md) instead of this file.

## Environment
### Preference
The Preference object has parameter and attributes of the system. You can access them by [Preference class](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/Preference.md).

### Environment variables
See [Environment class](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/Environment.md) to access them by JavaScript.
They will be shared beyond the processes.

## Releted document
* [Steel Wheels Project](http://steelwheels.github.io): Developer's web site.
