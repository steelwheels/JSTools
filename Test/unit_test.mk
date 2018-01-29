#
# unit_test.mk
#

jsrun 		= $(HOME)/tools/jstools/jsrun
jscat 		= $(HOME)/tools/jstools/jscat
test_dir	= ../Test
script_dir	= ../Test/Script
build_dir	= $(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)

all: all_jsrun all_jscat

#
# jsrun
#
all_jsrun: help nostrict hello cat0 cat1 exit0 json0 gr_primitive0 gr_view0
	@echo "*** test: Done ***"

help: dummy
	@echo "*** test: help ***"
	$(jsrun) --help 2>&1 | tee $(build_dir)/help.txt
	diff $(build_dir)/help.txt $(test_dir)/expected/help.txt

nostrict: dummy
	@echo "*** test: --no-strict ***"
	$(jsrun) --no-strict $(script_dir)/hello.js | \
		tee $(build_dir)/hello-no-strict.txt
	diff $(build_dir)/hello-no-strict.txt $(test_dir)/expected/hello.txt

hello: dummy
	@echo "*** test: hello ***"
	$(jsrun) $(script_dir)/hello.js | tee $(build_dir)/hello.txt
	diff $(build_dir)/hello.txt $(test_dir)/expected/hello.txt

cat0: dummy
	@echo "*** test: cat0 ***"
	echo "Good morning" | $(jsrun) $(script_dir)/cat0.js | \
	  tee $(build_dir)/cat0.txt
	diff $(build_dir)/cat0.txt $(test_dir)/expected/cat0.txt

cat1: dummy
	@echo "*** test: cat1 ***"
	$(jsrun) $(script_dir)/cat1.js | tee $(build_dir)/cat1.txt
	diff $(build_dir)/cat1.txt $(test_dir)/expected/cat1.txt

exit0: dummy
	@echo "*** test: exit0 ***"
	(if $(jsrun) $(script_dir)/exit0.js ; then \
		exit 1 ; \
	 else \
		exit 0 ; \
	 fi)

json0: dummy
	@echo "*** test: json0 ***"
	$(jsrun) $(script_dir)/json0.js | tee $(build_dir)/json0.txt
	mv data0-out.json $(build_dir)
	diff $(build_dir)/data0-out.json $(test_dir)/expected/data0-out.json

gr_primitive0 : dummy
	@echo "*** test: gr_primitive0 ***"
	$(jsrun) $(script_dir)/gr_primitive0.js | \
					tee $(build_dir)/gr_primitive0.txt
	diff $(build_dir)/gr_primitive0.txt \
					$(test_dir)/expected/gr_primitive0.txt

gr_view0 : dummy
	@echo "*** test: gr_view0 ***"
	$(jsrun) $(script_dir)/gr_view0.js | \
					tee $(build_dir)/gr_view0.txt
	diff $(build_dir)/gr_view0.txt \
					$(test_dir)/expected/gr_view0.txt

#
# jscat
#
all_jscat: jscat0 jscat1

jscat0: dummy
	$(jscat) < ../Test/data/json-empty.json > $(build_dir)/json-empty.json.out
	diff  $(build_dir)/json-empty.json.out ../Test/expected/json-empty.json.OK

jscat1: dummy
	$(jscat) ../Test/data/json-1data-0.json ../Test/data/json-1data-1.json \
	  > $(build_dir)/json-1data-0_1.json
	diff $(build_dir)/json-1data-0_1.json ../Test/expected/json-1data-0_1.json.OK

dummy:
