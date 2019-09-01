#
# unit_test.mk
#

jsrun 		= $(HOME)/tools/jstools/jsrun
jsh 		= $(HOME)/tools/jstools/jsh
jscat 		= $(HOME)/tools/jstools/jscat
jsgrep 		= $(HOME)/tools/jstools/jsgrep
test_dir	= ../Test
script_dir	= ../Test/Script
sample_dir	= ../Sample
resource_dir	= ../Resource/Sample
data_dir	= $(test_dir)/data
expected_dir	= $(test_dir)/expected
build_dir	= $(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)

all: all_jsrun all_jsh all_jscat all_jsgrep

#
# jsrun
#
all_jsrun: help nostrict hello cat0 cat1 exit0 exit1 enum0 json0 \
	   main0 main1 files urls operations errors \
	   math0
	@echo "*** test: Done ***"

help: dummy
	@echo "*** test: help ***"
	$(jsrun) --help 2>&1 | tee $(build_dir)/help.txt
	diff $(build_dir)/help.txt $(expected_dir)/help.txt

nostrict: dummy
	@echo "*** test: --no-strict ***"
	$(jsrun) --no-strict $(resource_dir)/hello-0.js | \
		tee $(build_dir)/hello-0-ns.txt
	diff $(build_dir)/hello-0-ns.txt $(expected_dir)/hello-0.txt

hello: dummy
	@echo "*** test: hello ***"
	$(jsrun) $(resource_dir)/hello-0.js | tee $(build_dir)/hello-0.txt
	diff $(build_dir)/hello-0.txt $(expected_dir)/hello-0.txt

cat0: dummy
	@echo "*** test: cat0 ***"
	echo "Good morning" | $(jsrun) $(script_dir)/cat0.js | \
	  tee $(build_dir)/cat0.txt
	diff $(build_dir)/cat0.txt $(expected_dir)/cat0.txt

cat1: dummy
	@echo "*** test: cat1 ***"
	$(jsrun) $(script_dir)/cat1.js | tee $(build_dir)/cat1.txt
	diff $(build_dir)/cat1.txt $(expected_dir)/cat1.txt

exit0: dummy
	@echo "*** test: exit0 ***"
	$(jsrun) --use-main $(script_dir)/exit0.js -- a b c | \
					tee $(build_dir)/exit0.txt
	diff $(build_dir)/exit0.txt $(expected_dir)/exit0.txt

exit1: dummy
	@echo "*** test: exit1 ***"
	(if $(jsrun) $(script_dir)/exit1.js ; then \
		exit 1 ; \
	 else \
		exit 0 ; \
	 fi)

enum0: dummy
	@echo "*** test: enum0 ***"
	$(jsrun) $(script_dir)/enum0.js | tee $(build_dir)/enum0.txt
	diff $(build_dir)/enum0.txt $(expected_dir)/enum0.txt

json0: dummy
	@echo "*** test: json0 ***"
	$(jsrun) $(script_dir)/json0.js | tee $(build_dir)/json0.txt
	mv data0-out.json $(build_dir)
	diff $(build_dir)/data0-out.json $(expected_dir)/data0-out.json

math0: dummy
	$(jsrun) $(script_dir)/math0.js | tee $(build_dir)/math0.txt
	diff $(build_dir)/math0.txt $(expected_dir)/math0.txt

main0: dummy
	@echo "*** test: main0 ***"
	$(jsrun) --use-main $(script_dir)/main0.js | \
					tee $(build_dir)/main0.txt
	diff $(build_dir)/main0.txt $(expected_dir)/main0.txt

main1: dummy
	@echo "*** test: main1 ***"
	$(jsrun) --use-main $(script_dir)/main0.js -- a b c | \
					tee $(build_dir)/main1.txt
	diff $(build_dir)/main1.txt $(expected_dir)/main1.txt

files: filetype

filetype: dummy
	@echo "*** Check file type 0 ***"
	touch $(build_dir)/check_file_type0.txt
	$(jsrun) --use-main \
		 $(script_dir)/check_file_type0.js \
		 -- $(build_dir)/check_file_type0.txt
	rm -f $(build_dir)/check_file_type0.txt

urls: dummy
	@echo "*** test: url9 ***"
	$(jsrun) $(script_dir)/url0.js | tee $(build_dir)/url0.txt
	diff $(build_dir)/url0.txt $(expected_dir)/url0.txt

operations: operation0 operation1

operation0: dummy
	if $(jsrun) --use-main $(script_dir)/operation0.js -- $(script_dir)/Operation/op0.js 2>&1 | tee $(build_dir)/operation0.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/operation0.txt $(expected_dir)/operation0.txt

operation1: dummy
	if $(jsrun) --use-main $(script_dir)/operation1.js 2>&1 | tee $(build_dir)/operation1.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/operation1.txt $(expected_dir)/operation1.txt

errors:	no_file_error syn_error

no_file_error: dummy
	if $(jsrun) no_file.js 2>&1 | tee $(build_dir)/no_file_error.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/no_file_error.txt $(expected_dir)/no_file_error.txt

syn_error: dummy
	if $(jsrun) $(script_dir)/syn_err0.js 2>&1 | tee $(build_dir)/syn_err0.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/syn_err0.txt $(expected_dir)/syn_err0.txt

#
# jsdh
#
all_jsh: args0 shell1 shell2 # shell0

args0: dummy
	@echo "*** test: Process.arguments ***"
	$(jsh) --use-main $(script_dir)/args.js -- a b c | \
					tee $(build_dir)/args.txt
	diff $(build_dir)/args.txt $(expected_dir)/args.txt

shell0: dummy
	$(jsh) -i < $(script_dir)/shell0.js

shell1: dummy
	$(jsh) $(script_dir)/shell1.js

shell2: dummy
	$(jsh) $(script_dir)/shell2.js

#
# jscat
#
all_jscat: jscat0 jscat1

jscat0: dummy
	$(jscat) < $(data_dir)/json-empty.json > $(build_dir)/json-empty.json.out
	diff  $(build_dir)/json-empty.json.out $(expected_dir)/json-empty.json.OK

jscat1: dummy
	$(jscat) $(data_dir)/json-1data-0.json $(data_dir)/json-1data-1.json \
	  > $(build_dir)/json-1data-0_1.json
	diff $(build_dir)/json-1data-0_1.json $(expected_dir)/json-1data-0_1.json.OK

#
# jsgrep
#
all_jsgrep: jsgrep0 jsgrep1 jsgrep2 jsgrep3 jsgrep4

jsgrep0: dummy
	$(jsgrep) --help 2>&1 | tee $(build_dir)/jsgrep-help.txt
	diff $(build_dir)/jsgrep-help.txt $(expected_dir)/jsgrep-help.txt.OK

jsgrep1: dummy
	$(jsgrep) -k data0 $(data_dir)/json-2data-0.json \
	  | tee $(build_dir)/jsgrep-2data-0.json
	diff -wB $(build_dir)/jsgrep-2data-0.json $(data_dir)/json-2data-0.json

jsgrep2: dummy
	$(jsgrep) -v hello $(data_dir)/json-2data-0.json \
	  | tee $(build_dir)/jsgrep-2data-2.json
	diff -wB $(build_dir)/jsgrep-2data-2.json $(data_dir)/json-2data-0.json

jsgrep3: dummy
	$(jsgrep) -p data1 hello $(data_dir)/json-2data-0.json \
	  | tee $(build_dir)/jsgrep-2data-3.json
	diff -wB $(build_dir)/jsgrep-2data-3.json $(data_dir)/json-2data-0.json

jsgrep4: dummy
	$(jsgrep) -p data0 hello $(data_dir)/json-2data-0.json \
	  | tee $(build_dir)/jsgrep-2data-4.json
	diff -wB $(build_dir)/jsgrep-2data-4.json $(expected_dir)/empty.txt.OK

dummy:
