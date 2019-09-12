# JSH: Extended JavaScript for Shell Scripting

## Introduction
This document describes about `JSH`. The JSH is small extension of JavaScript language to implement shell script.

The [bourne shell](https://en.wikipedia.org/wiki/Bourne_shell) and [csh](https://en.wikipedia.org/wiki/C_shell)  are popular to implement the shell script. But these syntax are very unique and inconsistent.
If you use `JSH`, you can implement the script based the JavaScript syntax.

The shell program [jsh](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) supports JSH.

## Features
This is the feature JavaScript shell:
* Support mixed description JavaScript and shell script.
* The line started by `>` is treated as the shell script. 


## Samples
### 1. Hello, world !!
Here is a sample script to print welcome message.
````
> echo "Hello, world !!" ;
````
To repeat the message, you can use `for` loop:
````
for(var i=0 ; i<10 ; i++){
        > echo "Hello, world: $i/10"
}

````

## Syntax

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
