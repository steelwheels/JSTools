# Name
*jsrun* - Execute JavaScript program on shell

# Synopsis
````
jsrun [options] script -- [arguments]
````
* options: command line options for `jsrun` command
* arguments: Arguments to be passed to JavaScript.

# Description
The *jsrun* is command line application to execute JavaScript program.

The following options are available:

|Short  |Long       |argument |Description            |
|:---   |:---       |:---      |:---                   |
|-h     |--help     |-         |Print help message     |
|       |--version  |-         |Print version information |
|       |--no-strict |-        |Do not use `strict` mode (If you don't give this option, the mode is set before compiling any scripts.)|
|       |--use-main |-         |Call main function in the script after evaluating scripts. |
|-l     |--lib      |libname  |Load built-in library named `libname`. The built-in library is JavaScript files which is distributed with JSTools package. For example, if you give `-l Graphics`, The `Graphics.js` in the package is loaded before parsing user scripts.|
|-i     |--interactive |-      | Set interactive mode. The user can input statements step by step. The interactive mode will be activated after reading all input scripts.|
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
