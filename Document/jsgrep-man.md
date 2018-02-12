# Name
*jsgrep* - Grep like command for JSON data

# Synopsys
````
jsgrep [options] file
````
# Description
The *jsgrep* command is used to print part of JSON data.
The unit of selection is an *object*.
The object which has matched property key and/or property value will be outputted.

# Command line options
|Short  |Long       |Parameter  |Description            |
|:---   |:---       |:---       |:---                   |
|-h     |--help     |-          |Print help message     |
|       |--version  |-          |Print version information |
|-k     |--key      |RegExp     |Select the object whose property key matches with the regular expression|
|-v     |--value    |RegExp     |Select the object whose property value matches with the regular expression|
|-p     |--property |Exp0 Exp1| Select the object whose property matches with the regular expressions for key and value|

The `--key` option is used to choose objects which has the matched property key.
The `--value` option is used to choose objects which has the matched property value.

# Exit status
|Value  |Description                          |
|:---   |:---                                 |
|0      |One or more objects were selected.   |
|1      |There were no matched objects        |
|2      |An error occurred                    |

# Examples
````
jsgrep --key "key0" --value "val1"    ... example1
jsgrep --property "key0" "val1"       ... example2
````
The following object matches pattern of *example1*. But does not match pattern of *example2*.
````
{
    key0 : val0,
    key1 : val1
}
````

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
