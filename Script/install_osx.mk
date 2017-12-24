#
# install.mk
#

INSTALL_PATH ?= $(HOME)/Library/Frameworks
TARGET_NAME  = jsrun

install: dummy
	xcodebuild build -target $(TARGET_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO
	xcodebuild install -target $(TARGET_NAME) \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

dummy:
