#
# install.mk
#

INSTALL_PATH ?= $(HOME)/Tools

BUNDLE_NAME  	= $(PROJECT_NAME)Bundle
MAIN_NAME     	= $(PROJECT_NAME)

all: dummy
	echo "Select target"

bundle: dummy
	xcodebuild build -target $(BUNDLE_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO
	xcodebuild install -target $(BUNDLE_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

main: dummy
	xcodebuild build -target $(MAIN_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO
	xcodebuild install -target $(MAIN_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

dummy:
