# Name
*jscat* - concatenate, merge and print JSON file

# Synopsis
````
jscat [options] [file ...]
````

# Description
The *jscat* command reads some JSON files and write them into standard output. This command merge JSON files based on following rules.

The destination file to be merged is called as `Fd` and source file to merge is called as `Fs`. To merge files, every member in the JSON data is picked up by depth first order.

# Exit status
|Value          | Description                   |
|:---           |:---                           |
|0              |Finished concatenation without any errors|
|1              |Invalid command line arguments         |
|2              |Failed to open input files      |

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
