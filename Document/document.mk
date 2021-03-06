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
     $(doc_dir)/amb-man.md \
     $(doc_dir)/samples/sample.md

$(doc_dir)/samples/sample.md: dummy
	(cd $(doc_dir)/samples ; make -f document.mk)

$(doc_dir)/jsh-man.md-in: $(doc_dir)/system/file-system.md

$(doc_dir)/amn-man.md-in: $(doc_dir)/system/file-system.md

clean:
	rm -f $(doc_dir)/jsh-lang.md
	rm -f $(doc_dir)/jsh-man.md
	(cd $(doc_dir)/samples ; make -f document.mk clean)

dummy:

