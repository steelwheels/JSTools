#
#
#

test_dir = ../Test

m4_cmd	= m4 --prefix-builtins \
	     --include=$(test_dir)/script \
	     --include=$(test_dir)/expected \
	     Script/m4_header.m4

%.md: %.md-in
	$(m4_cmd) $< > $@

all: jsh-lang.md

clean:
	rm -f jsh-lang.md

