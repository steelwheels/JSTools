# Name
*jsrun* - Execute JavaScript program on shell

# Synopsis
````
jsrun [options] script1 script2 ... scriptN
````

# Description
The *jsrun* is command line application to execute JavaScript program.

The following options are available:

|Short  |Long       |Description            |
|:---   |:---       |:---                   |
|-h     |--help     |Print help message     |
|       |--version  |Print version information |
|       |--no-strict |Do not use `strict` mode (If you don't give this option, the mode is set before compiling any scripts.)|
|-i     |--interactive | Set interactive mode. The user can input statements step by step. The interactive mode will be activated after reading all input scripts.|

# Exit status
|Value  |Description      |
|:---   |:---             |
|0      |The script is parsed and executed and finished without any errors |
|1      |Invalid command line arguments     |
|2      |Failed to execute JavaScript       |

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
