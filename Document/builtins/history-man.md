# *history* command

## Synopsis
````
history
````

## Description
Print the list of commands that they are already executed.

You can use `history` command to see the commands that you has been executed. The `!<num>` command can be used to replay it.

### Example
````
jsh> history
1 echo a
2 echo b
3 echo c
jsh> !1
a
````

## Related links
* [Built-in commands](https://github.com/steelwheels/JSTools/blob/master/Document/builtins/builtin-commands.md): Built-in shell commands
* [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md): Command line JavaScript shell
* [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/README.md): Terminal application to execute JavaScript shell.

