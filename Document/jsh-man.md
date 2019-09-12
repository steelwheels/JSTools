# Name
*jsh* - The platform to execute JavaScript Shell Program.

This document describes how to use the `jsh` application.
The syntax of this script is described in [jsh programming language](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).  

# Synopsis
````
jsh [options] script0 script1 ... scriptN -- argument0 ... argumentN
````
* options:  command line options for `jsh` command
* script:   JavaScript files to be loaded
* argument: Arguments to be passed as a parameter of the `main` function.

# Description
The *jsh* is command line application to execute JavaScript program.

The following options are available:

|Short  |Long       |argument |Description            |
|:---   |:---       |:---      |:---                   |
|-h     |--help     |-         |Print help message     |
|       |--version  |-         |Print version information |
|       |--no-strict |-        |Do not use `strict` mode (If you don't give this option, the mode is set before compiling any scripts.)|
|       |--use-main |-         |Call main function in the script after evaluating scripts. |
|-i     |--interactive |-      | Set interactive mode. The user can input statements step by step. The interactive mode will be activated after reading all scripts.|
|-c     |--compile  |-         |Dump the source scripts instead of executing it. If the script is written in [JSH](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md), it is converted into JavaScript and dumped. When you use this compile option, at least one JavaScript file must be given.|
|       |--         |-          |The arguments follows this will be passed as arguments for JavaScript code. |

By using `--` option, you can pass arguments to be referenced by the JavaScript code.

# Main function
When the `--use-main` option is given, the function named *main* is called (if it exists).
````
main(arguments: Array<String>) -> Int32
````
The `arguments` are defined by the command line arguments after `--` option.

# Programming manual
* [The standard library](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Library.md): The built-in JavaScript class, function, data structure. They will be always loaded before executing user scripts.

# Tools
|Tool name  |Description    |
|:---       |:---           |
|[util.js](https://github.com/steelwheels/JSTools/blob/master/Document/uti-js.md) |Get [UTI Information](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html#//apple_ref/doc/uid/TP40001319-CH201-SW1) from file |

# Sample scripts
See [sample scripts](https://github.com/steelwheels/JSTools/blob/master/Document/Sample/sample-scripts.md).

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
