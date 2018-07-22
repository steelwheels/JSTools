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
|-i     |--interactive |-      | Set interactive mode. The user can input statements step by step. The interactive mode will be activated after reading all input scripts.|
|       |--         |-          |The arguments follows this will be passed as arguments for JavaScript code. |

By using `--` option, you can pass arguments to be referenced by the JavaScript code.

# Main function
When the `--use-main` option is given, the function named *main* is called (if it exists).
````
main(arguments: Array<String>) -> Int32
````
The `arguments` are defined by the command line arguments after `--` option.

# Exit status
|Value  |Description      |
|:---   |:---             |
|0      |The script is parsed and executed and finished without any errors |
|1      |Invalid command line arguments     |
|2      |Failed to execute JavaScript       |

# Programming manual
* [Require statement](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/RequireFunc.md): Require: JavaScript module manager
* [Built-in Modules](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Library.md): The built-in JavaScript modules which is embedded in `jsrun` command.
* [Standard Libraries](https://github.com/steelwheels/JSTools/blob/master/Document/standard-lib.md): The standard libraries which is described by JavaScript. They are distributed with `jsrun` command.

# Tools
Some scripts are distributed with this command.
These file's locations are: `jstools.bundle/Contents/Resources/`.

|Tool name  |Description    |
|:---       |:---           |
|[util.js](https://github.com/steelwheels/JSTools/blob/master/Document/uti-js.md) |Get [UTI Information](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html#//apple_ref/doc/uid/TP40001319-CH201-SW1) from file |

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
