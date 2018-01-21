# Name
*jsrun* - Execute JavaScript program on shell

# Synopsis
````
jsrun [options] script1 script2 ... scriptN
````

# Description
The *jsrun* is command line application to execute JavaScript program.

The following options are available:

|Short  |Long       |Parameter  |Description            |
|:---   |:---       |:---       |:---                   |
|-h     |--help     |           |Print help message     |
|       |--version  |           |Print version information |

# Exit status
|Value  |Description      |
|:---   |:---             |
|0      |The script is parsed and executed and finished without any errors |
|1      |Invalid command line arguments     |
|2      |Failed to execute JavaScript       |

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
