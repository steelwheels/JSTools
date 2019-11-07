#
#
#

doc_dir    = ../Document
test_dir   = ../Test
sample_dir = ../Sample

m4_cmd	= m4 --prefix-builtins \
	     --include=$(test_dir)/script \
	     --include=$(test_dir)/expected \
	     --include=$(sample_dir) \
	     $(doc_dir)/Script/m4_header.m4

%.md: %.md-in
	$(m4_cmd) $< > $@

all: $(doc_dir)/jsh-lang.md $(doc_dir)/jsh-sample.md

clean:
	rm -f $(doc_dir)/jsh-lang.md

