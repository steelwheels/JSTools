# Name
*jsrun* - Execute JavaScript program on shell

# Synopsis
````
jsrun [options] script1 script2 ... scriptN
````

# Description
The *jsrun* is command line application to execute JavaScript program.

The following options are available:

|Short  |Long       |argument |Description            |
|:---   |:---       |:---      |:---                   |
|-h     |--help     |-         |Print help message     |
|       |--version  |-         |Print version information |
|       |--no-strict |-        |Do not use `strict` mode (If you don't give this option, the mode is set before compiling any scripts.)|
|-i     |--interactive |-      | Set interactive mode. The user can input statements step by step. The interactive mode will be activated after reading all input scripts.|
|-a     |--arguments |string |The string to be passed to JavaScript program.|

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

# Sample scripts
Some sample scripts are contained in the JSTool distribution package (and source core repository).
The file location is: `jstools.bundle/Contents/Resources/`.
There are some directories to categorize the software.
## Game
* Under construction

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
