See the source reference
[File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html) published by Apple.

## Kind of directories
* [Home Directory](#User): The directory prepared for each user's
* [Application Directory](#Application):  The directory used as an application resource.

## Home Directory
There are following directories under the home directory. In usually this directory is put on `~/Library/Containers/<Application>/Data`.
* `Documents/Script`: The directory to put sample scripts
* `Library`: The files provided by the application. The user can not touch here.
* `tmp`: Temporary directory

## Application Directory
The application resource is put in application or framework directory:
`~/Library/Frameworks/<Framework>.framework/Resource`.

## Reference
* [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md): Command line JavaScript shell.
* [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/README.md): Terminal application to execute JavaScript shell.
* [Steel Wheels Project](https://steelwheels.github.io): Project web site
