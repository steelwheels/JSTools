#
# unit_test.mk
#

jsrun 		= $(HOME)/tools/jstools/jsrun
test_dir	= ../Test
sample_dir	= ../Sample
build_dir	= $(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)

all: help hello
	echo "*** test: Done ***"

help: dummy
	echo "*** test: help ***"
	$(jsrun) --help 2>&1 | tee $(build_dir)/help.txt
	diff $(build_dir)/help.txt $(test_dir)/expected/help.txt

hello: dummy
	echo "*** test: hello ***"
	$(jsrun) $(sample_dir)/hello.js | tee $(build_dir)/hello.txt
	diff $(build_dir)/hello.txt $(test_dir)/expected/hello.txt

dummy:

