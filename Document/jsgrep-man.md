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
|-p     |--property |RegExp RegExp| Select the object whose property matches with the regular expressions for key and value|
|       |--and      |           |The object will be selected when the all regular expressions are matched  (This is *default* setting)|
|       |--or      |           |The object will be selected when at least one regular expressions is matched  |

The `--key` option is used to choose objects which has the matched property key with the given regular expression.
The `--value` option is used to choose objects which has the matched property value with the given regular expression.

# Exit status
|Value  |Description                          |
|:---   |:---                                 |
|0      |One or more objects were selected.   |
|1      |There were no matched objects        |
|2      |An error occurred                    |

# Examples
````
jsgrep --and --key "key0" --value "val1"  ... ex1
jsgrep --property "key0" "val1"           ... ex2
````
The following object matches pattern of ex1. But does not match pattern of ex2.
````
{
    key0 : val0,
    key1 : val1
}
````

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
