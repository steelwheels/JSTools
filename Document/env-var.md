# Environment variables

## Pre-defined environment variables

You can check these values by [getenv](https://github.com/steelwheels/JSTools/blob/master/Document/builtins/getenv-man.md) command.

|Name           |Description            |Related JavaScript function       |
|:---           |:---                   |                       |
|`JSH_VERSION`  |Shell version          |                       |
|`PWD`          |Current working directory |                    |
|`TMPDIR`       |User's temporary directory |[temporaryDirectory](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/FileManager.md) |

## Reference
### macOS environment
There are environment variables which defined at default shell (zsh).
````
TMPDIR=/var/folders/...snipped...
XPC_FLAGS=0x0
TERM_PROGRAM_VERSION=433
LANG=ja_JP.UTF-8
TERM_PROGRAM=Apple_Terminal
XPC_SERVICE_NAME=0
TERM_SESSION_ID=<DIGITS SEPARATED BY ->
TERM=xterm-256color
SSH_AUTH_SOCK=/private/...snipped...
SHELL=/bin/zsh
HOME=/Users/????
LOGNAME=????
USER=tomoo
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
SHLVL=1
PWD=...snipped...
OLDPWD=...snipped...
_=/usr/bin/printenv
````

### Links
* [Kiwi Library](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Library.md): Document for this library
