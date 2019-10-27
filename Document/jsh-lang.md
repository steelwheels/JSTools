

# jsh: JavaScript for Shell Scripting

## Introduction
This document describes about `jsh`. The jsh is extended JavaScript to make shell scripting easier.
You can mix the [bourne shell](https://en.wikipedia.org/wiki/Bourne_shell) script and JavaScript.

This is an simple example of `jsh` script:
````
for(let i=0 ; i<10 ; i++){
  > echo "Hello, world ${i}"
}
````

## Examples
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

## Syntax
The `jsh` supports mixed description JavaScript and shell script.
The shell script is started by `>`.
You can use the value of variable in JavaScript.
The value is declared as

Here is the pseudo BNF of shell script part.
````
shell_script    ::= `>` shell_statement { ';' shell_statement } <newline>
shell_statement ::= shell_command { '|' shell_command }
shell_command   ::= command [options] [parameters]
````

## Command
### Kind of commands
The command searching started from 1.
1. Built-in command
2. Internal command
3. External command

## Built-in command
* `return`: Feedback the values in shell script into the caller JavaScript

# Related document
* [Pysh](https://www.yunabe.jp/docs/pysh_overview.html): The rule to use `>` symbol is imported from this language.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
