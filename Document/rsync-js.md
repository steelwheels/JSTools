# Name
`rsync.js`: *rsync* wrapper to use JSON for configuration

# Synopsis
````
  rsync <config-file>
````

# Descriptions
The `rsync.js` is JavaScript program.
It wraps [rsync command](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/rsync.1.html) to make the JSON data can configure it's function.
The command accept the JSON file name as an argument.

# Configuration
The JSON  has following properties to control `rsync`:

|Name                   | Type  | Description |
|:---                   |:---   |:---
|source_directory       |String |Source directory to be copied|
|destination_directory  |String |Destination directory to placed copied files|

# Examples
Here is sample JSON description to control `rsync.js`.

# Related Links
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
