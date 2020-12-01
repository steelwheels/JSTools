#
#
#

bin_dir	= $(HOME)/tools/bin
amb_cmd = $(bin_dir)/amb

all: hello0

clean:
	rm -f *.amb.log

hello0: dummy
	$(amb_cmd) --log detail ./script/hello0.amb > hello0.amb.log
	diff hello0.amb.log expected/hello0.amb.log.OK

dummy:

