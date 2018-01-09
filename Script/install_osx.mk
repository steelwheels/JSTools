#
# install.mk
#

INSTALL_PATH ?= $(HOME)/Library/Frameworks
DMG_PATH     ?= $(HOME)/tools/archive

install: dummy
	xcodebuild install -target jsrun \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO
	xcodebuild install -target jscat \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO

make_dmg: dummy
	(cd $(DMG_PATH) && rm -rf jstools JSTools.dmg && mkdir jstools)
	(cd $(HOME)/tools ; tar cf - jstools) | (cd $(DMG_PATH)/jstools ; tar xfv -)
	cp ../Document/README.html $(DMG_PATH)/jstools
	hdiutil create $(DMG_PATH)/JSTools.dmg \
	  -volname "JSTools Disk Image" \
	  -srcfolder $(DMG_PATH)/jstools

dummy:
