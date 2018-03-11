# Main function

## Introduction
In usually, there are no `main` function on the JavaScript program.
But the [`jsrun`](https://github.com/steelwheels/JSTools/blob/master/Document/jsrun-man.md) command supports calling main function.
The function will be activated when the '`--arguments`' command line option is given.

## `main` method
Use can define the main function:
````
function main(arguments)
{
  return 0 ; // no error
}
````
### Parameter(s)
|Variable   |Class  | Description                     |
|:---       |:---   |:---                             |
|arguments  |Array of &lt;String&gt;|Command line arguments which is defined by '--argunents' option. |

### Return value
The type of return value is *signed integer*.
Use the following values as an exit code:

|Value      |Description          |
|:---       |:--                  |
|0          |Exit with no errors  |
|2          |Exit with some errors |

## Related links
* [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md): Top page of JSTools.
* [Steel Wheels Project](http://steelwheels.github.io): Developers web page.
