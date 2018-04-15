# Name
`rsync.js`: *rsync* wrapper to use JSON for configuration

# Synopsis
````
  jsrun --use-main --arguments <config-file> rsync.js 
````

# Descriptions
The `rsync.js` is JavaScript program.
It wraps [rsync command](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/rsync.1.html) to make the JSON data can configure it's function.
The command accept the JSON file name as an argument.

# Configuration
The JSON  has following properties to control `rsync`:

|Name                   | Type  | Description |
|:---                   |:---   |:---
|source_directory       |String |Source directory to be copied. This is always required.|
|destination_directory  |String |Destination directory to placed copied files.  This is always required.|
|verbose_mode           |Bool   |The default value is *false*. If this is true, the log message for debugging will be outputted. |
|dry_run                |Bool   |The default value is *false*. If this is true, the rsync command with arguments is printed instead of execute it.|

# Examples
Here is sample JSON description to control `rsync.js`.

# Related Links
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
