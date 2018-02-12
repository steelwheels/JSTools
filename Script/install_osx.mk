#
# install.mk
#

INSTALL_PATH ?= $(HOME)/Library/Frameworks
DMG_PATH     ?= $(HOME)/tools/archive

TARGET_LIST  = jsrun jscat jsadb jsgrep

install: dummy
	for targ in $(TARGET_LIST) ; do \
		if xcodebuild install -target $$targ \
		  -project $(PROJECT_NAME).xcodeproj \
		  -configuration Release DSTROOT=/ ONLY_ACTIVE_ARCH=NO ; then \
			echo "done" ; \
		else \
			echo "*** Failed" ; \
			exit 1; \
		fi ; \
	done

make_dmg: dummy
	mkdir -p $(DMG_PATH)
	(cd $(DMG_PATH) && rm -rf jstools JSTools.dmg && mkdir jstools)
	(cd $(HOME)/tools ; tar cf - jstools) | (cd $(DMG_PATH)/jstools ; tar xfv -)
	cp ../Document/README.html $(DMG_PATH)/jstools
	hdiutil create $(DMG_PATH)/JSTools.dmg \
	  -volname "JSTools Disk Image" \
	  -srcfolder $(DMG_PATH)/jstools

dummy:
