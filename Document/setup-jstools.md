# Setup JSTools
## Setup after installation
Add command search path for JSTools.
If you use `bash`, edit `.bash_profile`:
````
# jstools
JSTOOLS_DIR="${HOME}/tools/jstools"
if [ -d ${JSTOOLS_DIR} ] ; then
	PATH="${JSTOOLS_DIR}:$PATH" ;
fi
````

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
