#
# unit_test.mk
#

jsrun 		= $(HOME)/tools/jstools/jsrun
jsh 		= $(HOME)/tools/jstools/jsh
jscat 		= $(HOME)/tools/jstools/jscat
jsgrep 		= $(HOME)/tools/jstools/jsgrep
test_dir	= ../Test
script_dir	= ../Test/script
sample_dir	= ../Sample
data_dir	= $(test_dir)/data
expected_dir	= $(test_dir)/expected
build_dir	= $(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)

all: all_jsh all_jscat all_jsgrep

#
# jsh
#
all_jsh: help nostrict hello exit0 exit1 exit2 args0 enum0 math0 shell1 if0 \
	 main0 main1 cat0 cat1 pipe0 pipe1 pipe2 pipe3 fmgr0 \
	 hello0 hello1 json0 filetype0 url0 \
	 operation0 operation1 thread0 process0 run0 run1 env0 sleep \
	 no_file_error syn_error

help: dummy
	@echo "*** test: help ***"
	$(jsh) --help 2>&1 | tee $(build_dir)/help.txt
	diff $(build_dir)/help.txt $(expected_dir)/help.txt

nostrict: dummy
	@echo "*** test: --no-strict ***"
	$(jsh) --no-strict $(script_dir)/hello0.js | \
		tee $(build_dir)/hello-0-ns.txt
	diff $(build_dir)/hello-0-ns.txt $(expected_dir)/hello-0.txt

hello: dummy
	@echo "*** test: hello ***"
	$(jsh) $(script_dir)/hello0.js | tee $(build_dir)/hello-0.txt
	diff $(build_dir)/hello-0.txt $(expected_dir)/hello-0.txt

exit0: dummy
	@echo "*** test: exit0 ***"
	$(jsh) --use-main $(script_dir)/exit0.js -- a b c | \
					tee $(build_dir)/exit0.txt
	diff $(build_dir)/exit0.txt $(expected_dir)/exit0.txt

exit1: dummy
	@echo "*** test: exit1 ***"
	(if $(jsh) $(script_dir)/exit1.js ; then \
		exit 1 ; \
	 else \
		exit 0 ; \
	 fi)

exit2: dummy
	@echo "*** test: exit2 ***"
	$(jsh) $(script_dir)/exit2.jsh | tee $(build_dir)/exit2.txt
	diff $(build_dir)/exit2.txt $(expected_dir)/exit2.txt

args0: dummy
	@echo "*** test: Process.arguments ***"
	$(jsh) --use-main $(script_dir)/args.js -- a b c | \
					tee $(build_dir)/args.txt
	diff $(build_dir)/args.txt $(expected_dir)/args.txt

enum0: dummy
	@echo "*** test: enum0 ***"
	$(jsh) $(script_dir)/enum0.js | tee $(build_dir)/enum0.txt
	diff $(build_dir)/enum0.txt $(expected_dir)/enum0.txt

math0: dummy
	$(jsh) $(script_dir)/math0.js | tee $(build_dir)/math0.txt
	diff $(build_dir)/math0.txt $(expected_dir)/math0.txt

shell0: dummy
	$(jsh) -i < $(script_dir)/shell0.js

shell1: dummy
	$(jsh) $(script_dir)/shell1.js

if0: dummy
	$(jsh) $(script_dir)/if0.jsh | tee $(build_dir)/if0.txt
	diff $(build_dir)/if0.txt $(expected_dir)/if0.txt

main0: dummy
	@echo "*** test: main0 ***"
	$(jsh) --use-main $(script_dir)/main0.js | \
					tee $(build_dir)/main0.txt
	diff $(build_dir)/main0.txt $(expected_dir)/main0.txt

main1: dummy
	@echo "*** test: main1 ***"
	$(jsh) --use-main $(script_dir)/main0.js -- a b c | \
					tee $(build_dir)/main1.txt
	diff $(build_dir)/main1.txt $(expected_dir)/main1.txt

cat0: dummy
	@echo "*** test: cat0 ***"
	echo "Good morning" | $(jsh) $(script_dir)/cat0.js | \
	  tee $(build_dir)/cat0.txt
	diff $(build_dir)/cat0.txt $(expected_dir)/cat0.txt

cat1: dummy
	@echo "*** test: cat1 ***"
	$(jsh) $(script_dir)/cat1.js | tee $(build_dir)/cat1.txt
	diff $(build_dir)/cat1.txt $(expected_dir)/cat1.txt

pipe0: dummy
	@echo "*** test: pipe0 ***"
	$(jsh) $(script_dir)/pipe0.js | tee $(build_dir)/pipe0.txt
	diff $(build_dir)/pipe0.txt $(expected_dir)/pipe0.txt

pipe1: dummy
	@echo "*** test: pipe1 ***"
	$(jsh) $(script_dir)/pipe1.js | tee $(build_dir)/pipe1.txt
	diff $(build_dir)/pipe1.txt $(expected_dir)/pipe1.txt

pipe2: dummy
	@echo "*** test: pipe2 ***"
	$(jsh) $(script_dir)/pipe2.js | tee $(build_dir)/pipe2.txt
	diff $(build_dir)/pipe2.txt $(expected_dir)/pipe2.txt

pipe3: dummy
	@echo "*** test: pipe3 ***"
	$(jsh) $(script_dir)/pipe3.jsh | tee $(build_dir)/pipe3.txt
	diff $(build_dir)/pipe3.txt $(expected_dir)/pipe3.txt

fmgr0: dummy
	@echo "*** test: fmgr0 ***"
	$(jsh) --use-main $(script_dir)/fmgr0.js | tee $(build_dir)/fmgr0.txt
	diff $(build_dir)/fmgr0.txt $(expected_dir)/fmgr0.txt

hello0: dummy
	@echo "*** test: hello0 ***"
	$(jsh) $(script_dir)/hello0.jsh | tee $(build_dir)/hello0.txt
	diff $(build_dir)/hello0.txt $(expected_dir)/hello0.txt

hello1: dummy
	@echo "*** test: hello1 ***"
	$(jsh) $(script_dir)/hello1.jsh | tee $(build_dir)/hello1.txt
	diff $(build_dir)/hello1.txt $(expected_dir)/hello1.txt

json0: dummy
	@echo "*** test: json0 ***"
	$(jsh) $(script_dir)/json0.js | tee $(build_dir)/json0.txt
	mv data0-out.json $(build_dir)
	diff $(build_dir)/data0-out.json $(expected_dir)/data0-out.json

filetype0: dummy
	@echo "*** Check file type 0 ***"
	touch $(build_dir)/check_file_type0.txt
	$(jsh) --use-main \
		 $(script_dir)/check_file_type0.js \
		 -- $(build_dir)/check_file_type0.txt
	rm -f $(build_dir)/check_file_type0.txt

url0: dummy
	@echo "*** test: url0 ***"
	$(jsh) $(script_dir)/url0.js | tee $(build_dir)/url0.txt
	diff $(build_dir)/url0.txt $(expected_dir)/url0.txt

operation0: dummy
	if $(jsh) --use-main $(script_dir)/operation0.js -- $(script_dir)/Operation/op0.js 2>&1 | tee $(build_dir)/operation0.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/operation0.txt $(expected_dir)/operation0.txt

operation1: dummy
	if $(jsh) --use-main $(script_dir)/operation1.js 2>&1 | tee $(build_dir)/operation1.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/operation1.txt $(expected_dir)/operation1.txt

thread0: dummy
	@echo "*** test: thread0 ***"
	$(jsh) --use-main $(script_dir)/thread0.jspkg | tee $(build_dir)/thread0.txt
	diff $(build_dir)/thread0.txt $(expected_dir)/thread0.txt

process0: dummy
	@echo "*** test: process0 ***"
	$(jsh) $(script_dir)/process0.js | tee $(build_dir)/process0.txt
	diff $(build_dir)/process0.txt $(expected_dir)/process0.txt

run0: dummy
	@echo "*** test: run0 ***"
	$(jsh) --use-main $(script_dir)/run0.js | tee $(build_dir)/run0.txt
	diff $(build_dir)/run0.txt $(expected_dir)/run0.txt

run1: dummy
	@echo "*** test: run1 ***"
	$(jsh) $(script_dir)/run1.jsh | tee $(build_dir)/run1.txt
	diff $(build_dir)/run1.txt $(expected_dir)/run1.txt

env0: dummy
	@echo "*** test: env0 ***"
	$(jsh) --use-main $(script_dir)/env0.js | tee $(build_dir)/env0.txt
	diff $(build_dir)/env0.txt $(expected_dir)/env0.txt

sleep: dummy
	@echo "*** test: sleep ***"
	$(jsh) --use-main $(script_dir)/sleep.js | tee $(build_dir)/sleep.txt
	diff $(build_dir)/sleep.txt $(expected_dir)/sleep.txt

no_file_error: dummy
	if $(jsh) no_file.js 2>&1 | tee $(build_dir)/no_file_error.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/no_file_error.txt $(expected_dir)/no_file_error.txt

syn_error: dummy
	if $(jsh) $(script_dir)/syn_err0.js 2>&1 | tee $(build_dir)/syn_err0.txt ; \
	then \
		echo "Error expected" >&2 ; \
	else \
		echo "Catch expected error" >&2 ; \
	fi
	diff $(build_dir)/syn_err0.txt $(expected_dir)/syn_err0.txt

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
