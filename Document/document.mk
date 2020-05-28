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

all: $(doc_dir)/jsh-lang.md \
     $(doc_dir)/jsh-man.md \
     $(doc_dir)/samples/sample.md

$(doc_dir)/samples/sample.md: dummy
	(cd samples ; make -f document.mk)

$(doc_dir)/jsh-man.md-in: system/file-system.md

clean:
	rm -f $(doc_dir)/jsh-lang.md
	rm -f $(doc_dir)/jsh-man.md
	(cd samples ; make -f document.mk clean)

dummy:

