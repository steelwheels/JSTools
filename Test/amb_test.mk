#
#
#

bin_dir	= $(HOME)/tools/bin
amb_cmd = $(bin_dir)/amb

all: hello0 synerr0

clean:
	rm -f *.amb.log

hello0: dummy
	$(amb_cmd) --log detail ./script/hello0.amb >& hello0.amb.log
	diff hello0.amb.log expected/hello0.amb.log.OK

synerr0: dummy
	$(amb_cmd) --log detail ./script/synerr0.amb >& synerr0.amb.log || \
	diff synerr0.amb.log expected/synerr0.amb.log.OK

dummy:

