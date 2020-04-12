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
