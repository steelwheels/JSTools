#
#
#

doc_dir    	= ../../Document
sample_dir	= ../../Sample

m4_cmd	= m4 --prefix-builtins \
	     --include=$(test_dir)/script \
	     --include=$(test_dir)/expected \
	     --include=$(sample_dir) \
	     $(doc_dir)/Script/m4_header.m4

%.md: %.md-in
	$(m4_cmd) $< > $@

all: sample.md

clean:
	rm -f sample.md


