#
# install.mk
#

PROJECT_NAME ?= JSTools
INSTALL_PATH ?= $(HOME)/Library/Frameworks
DMG_PATH     ?= $(HOME)/tools/archive

TARGET_LIST  = jsh

install: install_bundle install_jsh install_amb

install_bundle: dummy
	xcodebuild install -target JSToolsBundle \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release \
	   DSTROOT=/ \
	   ONLY_ACTIVE_ARCH=NO 

install_jsh: dummy
	xcodebuild install -target jsh \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release \
	   DSTROOT=/ \
	   ONLY_ACTIVE_ARCH=NO 

install_amb: dummy
	xcodebuild install -target amb \
	  -project $(PROJECT_NAME).xcodeproj \
	  -configuration Release \
	   DSTROOT=/ \
	   ONLY_ACTIVE_ARCH=NO 

make_dmg: make_dmg_dir make_dmg_binary make_dmg_tool make_dmg_doc make_dmg_pack

make_dmg_dir: dummy
	mkdir -p $(DMG_PATH)
	(cd $(DMG_PATH) && rm -rf jstools JSTools.dmg && mkdir jstools)

make_dmg_binary: dummy
	(cd $(HOME)/tools ; tar cf - jstools) | (cd $(DMG_PATH)/jstools ; tar xfv -)

make_dmg_tool: dummy
	mkdir -p $(DMG_PATH)/jstools/scripts
	install -C -m 0444 ../Tools/uti.js $(DMG_PATH)/jstools/scripts

make_dmg_doc: dummy
	cp ../Document/README.txt $(DMG_PATH)/jstools

make_dmg_pack: dummy
	hdiutil create $(DMG_PATH)/JSTools.dmg \
	  -volname "JSTools Disk Image" \
	  -srcfolder $(DMG_PATH)/jstools

dummy:
