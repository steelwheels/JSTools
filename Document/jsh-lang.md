# jsh: Language Manual

## Introduction
 The `jsh` is extended JavaScript to make shell scripting easier. It is supported by [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/README.md) and [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md).

This document describes about the syntax of `jsh`.
You can mix the [bourne shell](https://en.wikipedia.org/wiki/Bourne_shell) script and JavaScript.
The shell script part is translated into JavaScript code before
executing by JavaScript engine. And this document does not describe about programming environment. If you want know about it, see [jsh system](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-sys.md).

This is an simple example of `jsh` script:
````
for(let i=0 ; i<10 ; i++){
  > echo "Hello, world ${i}"
}
````
Following page contains some
[sample scripts](https://github.com/steelwheels/JSTools/blob/master/Document/samples/sample.md)
for `jsh`.

## Features
This section describes the feature of this software by real examples.
### Hello, world
This usual examples but message is written in capital letters:
````
> echo "Hello, world" | tr [a-z] [A-Z]
````
Multiple lines which started by `>` are treated as single shell script.
````
> echo "Hello, world"
>  | tr [a-z] [A-Z]
````
### Parameter passing
You can pass the parameter from JavaScript to shell script.
The `${varname}` in the shell script is replaced by
the value of the variable in the JavaScript
````
for(let i=0 ; i<10 ; i++){
  > echo "Loop count: ${i}"
}
````

### Pipeline to connect JavaScript and Shell script
You can use the pipe in the shell script which is defined in the JavaScript.
The identifier which is started by `@` is treated as the pipe name.
````
let pipe = Pipe() ;
> echo "Hello, world" > @Pipe
dump(pipe) ;
````

### Pass exit code from shell process to caller JavaScript
If you put `-> var` at the last of shell script.
The variable will have exit code of it.
````
let ecode = 0 ;
> grep "a" ~/tmp_dir/a -> ecode
if(ecode == 0){
  console.print("matched\n") ;
} else {
  console.print("not matched\n") ;
}
````

### Thread
The `Thread` function is used to generate thread to execute
the user defined JavaScript.
The script must be placed in the package.
````
function main(args)
{
	console.print("Hello from main function\n") ;

	let thread0 = Thread("thread0", stdin, stdout, stderr) ;
	let result  = -1 ;
	if(thread0 != null){
		console.print("start: thread0\n") ;
		thread0.start(["a", "b"]) ;
		console.print("start: wait until exit\n") ;
		let ecode = thread0.waitUntilExit() ;
		console.print("exit code = " + ecode + "\n") ;
		result = ecode ;
	} else {
		console.print("start: FAILED\n") ;
		console.error("Failed to allocate thread\n") ;
	}
	return result ;
}


````

## Syntax
The `jsh` supports mixed description JavaScript and shell script.
The shell script is started by `>`.

Here is the pseudo BNF of shell script part.
It assume the prefix symbol ('>') has been removed.

````
shell_script      ::= multi_statements  ['->' varname]
multi_statements  ::= pipe_statement { ';' pipe_statement }*
pipe_statement    ::= shell_statement { '|' shell_statement }*
````

## Library
* [The standard library](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Library.md): The built-in JavaScript class, function, data structure. They will be always loaded before executing user scripts.

# Sample scripts
|Tool name  |Description    |
|:---       |:---           |
|[util.js](https://github.com/steelwheels/JSTools/blob/master/Document/uti-js.md) |Get [UTI Information](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html#//apple_ref/doc/uid/TP40001319-CH201-SW1) from file |

## Related document
* [README](https://github.com/steelwheels/JSTools/blob/master/README.md): Summary of this repository
* [jsh command](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-man.md): `jsh` command line application.
* [sample scripts](https://github.com/steelwheels/JSTools/blob/master/Document/samples/sample.md): Sample scripts for `jsh`.
* [Pysh](https://www.yunabe.jp/docs/pysh_overview.html): The rule to use `>` symbol is imported from this language.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
