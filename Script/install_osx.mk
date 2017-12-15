#
# install.mk
#

INSTALL_PATH ?= $(HOME)/Tools

BUNDLE_NAME  	= JSToolsBundle
APP_NAME     	= jsrun

all: bundle application

bundle: dummy
	xcodebuild build -target $(BUNDLE_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO
	xcodebuild install -target $(BUNDLE_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

application: dummy
	xcodebuild build -target $(APP_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO
	xcodebuild install -target $(APP_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

dummy:
