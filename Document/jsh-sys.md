# jsh: System Reference Manual

## Introduction
 The `jsh` is extended JavaScript to make shell scripting easier. It is supported by [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/README.md) and [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md).

This document describes about programming environment of `jsh`. There are many built-in libraries, functions and global variables. And this document does not describe about language syntax. If you want know about it, see [jsh language](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).

## Contents
* [Job control](#Job_Control)
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

![Two modes](Images/mode2.png)

### Stop the process
* _For JSTerminal_: You can stop the process by pressing CTRL-C key.
* _For jsh commandline_: You can stop the process in the current window by choosing
_Stop menu item_ at Edit menu or pressing COMMAND-. key (`period` key + `command` key).

## Environment
### Environment variables
See [Environment class](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/Environment.md) to access them by JavaScript.
They will be shared beyond the processes.

## Releted document
* [Steel Wheels Project](http://steelwheels.github.io): Developer's web site.
