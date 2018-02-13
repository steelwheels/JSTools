# Name
*jsadb* - Read, write and update AddressBook database

# Synopsis
````
jsadb sub-command [options] [file]
````

# Description
The AddressBook data base operates [Contact Object](https://github.com/steelwheels/Canary/blob/master/Document/contact-object.md).
The *jsadb* command read, write and update the database.

The command has sub commands to decide the operation.
Following sub commands are supported:

|Command  |Description                      |
|:---     |:---                             |
|dump     |Dump contents of database by the JSON file format|

These options works without sub command.
They called as default options.

|Short  |Long       |Parameter  |Description            |
|:---   |:---       |:---       |:---                   |
|-h     |--help     |-          |Print help message     |
|       |--version  |-          |Print version information |


# Sub commands
## `dump` command
Dump the content of AddressBook database.

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
