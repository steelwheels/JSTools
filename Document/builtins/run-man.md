# *run* command

## Synopsis
````
run [script-file] [argument] [redirect]
````
###  Sample
````
run                             // Open file selector and execute it (OSX)
run cmd.js                      // Execute script, "cmd.js"
run cmd.js {message: "hello" }  // Execute script with argument
run > @pipe                     // Switch the output to the pipe
````

## Description
Execute the JavaScript or JavaScript shell script.
The path of the script file is given as first argument.
If you don't give it, the file selector will be opened before execution
(for macOS only).

The second argument will be used as a parameter for the main function
in the script. See the next section [Arguments](#Arguments).

The last argument is used to redirect the input or output for the script.
See the next section [Redirect](#Redirect).

## Arguments to the script
The argument which following the script path and preceding redirect is treated as parameters for the `main` function in the script.

## Redirect
The run command supports only _named pipe_.
The named pipe is defined in the JavaScript statement.
This is sample script.
````
let pipeA = Pipe() ;
> run script.js > @pipeA
````
For more precise, see the language manual, [Extended JavaScript for Shell Scripting](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).

## Related documents
* [JSTools](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md): The command line `jsh` shell
* [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/Documents/UsersManual.md): The terminal application to execute `jsh`
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
