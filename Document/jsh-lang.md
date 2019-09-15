

# JSH: Extended JavaScript for Shell Scripting

## Introduction
This document describes about `JSH`. The JSH is small extension of JavaScript language to implement shell script easily.

The [bourne shell](https://en.wikipedia.org/wiki/Bourne_shell) and [csh](https://en.wikipedia.org/wiki/C_shell)  are popular to implement the shell script. But these syntax are very unique and inconsistent.
If you use `JSH`, you can implement the script based the JavaScript syntax.

The shell program [jsh](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md) supports JSH.

## Features
This is the feature JSH:
* Support mixed description JavaScript and shell script.
* The data flow is managed by shell script (called as `shell-statement`)
* The control flow is managed by JavaScript

Here is a sample script to print welcome message.
````
for(var i=0 ; i<3 ; i++){
	> echo "hello, world ${i}"
}

````
The execution result is:
````
hello, world 0
hello, world 1
hello, world 2

````

## Syntax
Following line is recognized as shell statement.
This is full declaration of shell statement.
````
(in, out, err, env) -> exit > ... shell statement ...
````

Each parameter has default value. It is used when the parameter value is omitted.

|Name   |Type           |Description                            |
|:---   |:---           |:---                                   |
|in     |File           |Input file for shell statement. Default value is `stdin`. |
|out    |File           |Output file. Default value is `stdout`. |
|err    |File           |File for error. Default value is `stderr`. |
|env    |Dictionary     |Set of environment values. Default value is none. |
|exit   |Int            |Exit code set by execution result. |

Some parameters can be omitted:
````
(in, out, err) -> exit      > ... shell statement ...   # 1
(in, out, err, env) -> exit > ... shell statement ...   # 2
(in, out, err, env)         > ... shell statement ...   # 3
(in, out, err)              > ... shell statement ...   # 4
                            > ... shell statement ...   # 5
````

## Samples
### 1. Hello, world !!
You can use *pipe* and define *multiple statements* separated by ';'.
The file `stdin`, `stdout` and `stderr` are used.
````
for(var i=0 ; i<3 ; i++){
	> echo "hello, world ${i}" | tr [a-z] [A-Z] ; echo "Good morning"
}

````
The execution result is:
````
HELLO, WORLD 0
Good morning
HELLO, WORLD 1
Good morning
HELLO, WORLD 2
Good morning

````

### 2. File streams
You can use [Pipe](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/Pipe.md) to connect file stream.
````
/**
 * pipe2.js
 */

/**
 * Allocate Pipe objects to connect data stream
 */
let pipe0 = Pipe() ;
let pipe1 = Pipe() ;

/**
 * Execute "cat" command to copy input into output
 *   - The pipe0 object is connected with input
 *   - The pipe1 object is connected with output
 */
console.log("[allocate process]\n") ;
let process = system("/bin/cat", pipe0.reading, pipe1.writing, stderr) ;
if(process == null){
	console.log("[Error] Could not launch command\n") ;
	exit(1) ;
}

/*
 * send input data into pipe0 
 */
console.log("[send input]\n") ;
pipe0.writing.put("Input from JavaScript !!\n") ;
pipe0.writing.close() ;

/*
 * receive output data from pipe1
 */
console.log("[receive output]\n") ;
let c = pipe1.reading.getc() ;
while(c != null){
	console.log(`[receive] ${c}\n`) ;
	c = pipe1.reading.getc() ;
}

/*
 * Wait the cat process finished
 */
process.waitUntilExit() ;

console.log("[bye]\n");


````

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Pysh](https://www.yunabe.jp/docs/pysh_overview.html): How to write Pysh script in Japanese.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
