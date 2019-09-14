#
#
#

test_dir = ../Test
doc_dir  = ../Document

m4_cmd	= m4 --prefix-builtins \
	     --include=$(test_dir)/script \
	     --include=$(test_dir)/expected \
	     $(doc_dir)/Script/m4_header.m4

%.md: %.md-in
	$(m4_cmd) $< > $@

all: $(doc_dir)/jsh-lang.md

clean:
	rm -f $(doc_dir)/jsh-lang.md

