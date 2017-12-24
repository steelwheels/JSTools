# Name
*jsrun* - Execute JavaScript program on shell

# Synopsys
````jsrun [options] script1 script2 ... scriptN````

# Description
The *jsrun* is command line application to execute JavaScript program.

The following options are available:
<table width="80%" align="center">
 <tr>
   <td>-h</td><td>--help</td>
   <td>Print help message</td>
 </tr>
 <tr>
   <td></td><td>--version</td>
   <td>Print version information</td>
 </tr>
</table>

# Exit status
<table width="80%" align="center">
  <tr><td>Code</td><td>Description</td></tr>
  <tr><td>0</td><td>The script is parsed and executed and finished without any errors</td></tr>
  <tr><td>1</td><td>Invalid command line arguments</td></tr>
  <tr><td>2</td><td>Failed to execute JavaScript</td></tr>
</table>

# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
