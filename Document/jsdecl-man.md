

# Name
*jsdecl* - Generate declaration file (*.d.ts) for JSTerminal

This document describes how to use the `jsdecl` command line application.

# Synopsis
````
jsdecl [options] [package-dir]
jsdecl -b | --builtin
````
* options:  command line options 
* package-dir: The JavaScript package directory

# Description
The *jsdecl* command is used to generate TypeScript declaration file (`*.d.ts` file) from the [JavaScript package](https://github.com/steelwheels/JSTools/blob/master/Document/jspkg.md). The package is used to implement application script for [JSTerminal](https://github.com/steelwheels/JSTerminal#readme). 

The following options are available:

|Short  |Long       |argument |Description            |
|:---   |:---       |:---      |:---                   |
|-h     |--help     |-         |Print help message     |
|       |--version  |-         |Print version information |
|-b     |--builtin  |-         |Generate declaration of built-in data type |

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Environment variables](https://github.com/steelwheels/JSTools/blob/master/Document/env-var.md): Pre-defined environment variables
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
