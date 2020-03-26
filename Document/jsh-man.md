# Name
*jsh* - JavaScript Shell

This document describes how to use the `jsh` application.
The syntax of this script is described in [jsh programming language](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).  
See [samples](https://github.com/steelwheels/JSTools/blob/master/Document/samples/sample.md) for some sample scripts.

# Synopsis
````
jsh [options] script0.js script1.js ... scriptN.js [-- argument0 ... argumentM]
jsh [options] package.jspkg [-- argument0 ... argumentM]
jsh [options]
````
* options:  command line options for `jsh` command
* script:   JavaScript files to be executed
* package:  JavaScript package to be executed. For more details, see [JavaScrip package](https://github.com/steelwheels/JSTools/blob/master/Document/jspkg.md).
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
|       |--log      |string     |Define debug log level. The default level is *normal*. Select 1 item from following levels: "normal", "flow", "detail" |
|       |--         |-          |The arguments follows this will be passed as arguments for JavaScript code. |

By using `--` option, you can pass arguments to be referenced by the JavaScript code.
If you don't give any script file names, the `jsh` boots with interactive mode.

# Main function
When the `--use-main` option is given, the function named *main* is called (if it exists).
````
main(arguments: Array<String>) -> Int32
````
The `arguments` are defined by the command line arguments after `--` option.

# Interactive mode
The last symbol of the prompt string presents the *input mode*.
It defines the kind of default script at the command line.

|Symbol |Mode named             |Acceptable script      |
|:---   |:---                   |:---                   |
|`>`    |Shell script mode      |Shell script           |
|`%`    |JavaScript mode        |JavaScript             |

For example, the prompt `jsh>` presents shell script mode, `jsh%` is JavaScript mode. You can use `>` or `%` prefix to select mode manually.
````
jsh% > echo "Hello"
jsh> % let a = 10 ;
````
You can switch the mode. When you press `>` and enter key, the mode is switched into shell script mode. The `%` is used for JavaScript mode.

# Built-in Shell Commands
## `cd` command
Change the current directory.
````
jsh> pwd
/private/tmp/powerlog
jsh> cd ..
jsh> pwd
/private/tmp
````

## `history` command
You can use `history` command to see the commands that you has been executed. The `!<num>` command can be used to replay it.

````
jsh> history
1 echo a
2 echo b
3 echo c
jsh> !1
a
````

## `run` command
Execute JavaScript program by shell-command.
See [run command](https://github.com/steelwheels/JSTools/blob/master/Document/builtins/run-man.md)

## other commands
* [fonts](https://github.com/steelwheels/JSTools/blob/master/Document/builtins/fonts-man.md) command: get information about fonts.

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Environment variables](https://github.com/steelwheels/JSTools/blob/master/Document/env-var.md): Pre-defined environment variables
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
