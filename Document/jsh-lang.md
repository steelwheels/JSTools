# JavaScript-Shell programming language

## Introduction
This document describes about `JavaScript-Shell` programming language.
It is used to implement shell script for Unix (or Unix like) systems.

The [bourne shell](https://en.wikipedia.org/wiki/Bourne_shell) and [csh](https://en.wikipedia.org/wiki/C_shell)  are popular to implement the shell script. But these syntax are very unique and inconsistent.
If you use `JavaScript-Shell`, you can implement the script based the JavaScript syntax.

The shell program which supports `JavaScript-Shell` is `jsh`. For more precise see the manual page [jsh](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md).

## Features
This is the feature JavaScript shell:
* JavaScript based with small extension to mix shell operation.
* The line which is started by `>` is treated as shell operation. The line will be parsed by pre-processor and converted into JavaScript.

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
