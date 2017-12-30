#
# install.mk
#

INSTALL_PATH ?= $(HOME)/Library/Frameworks

install: dummy
	xcodebuild install -target jsrun \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

dummy:
