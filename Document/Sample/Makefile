#
#
#

sample_dir   = ../../Sample
resource_dir = ../../Resource/Sample

m4_cmd	= m4 --prefix-builtins \
	     --include=$(sample_dir) \
	     --include=$(resource_dir) \
	     ../Script/m4_header.m4

%.md: %.md-in
	$(m4_cmd) $< > $@

all: sample-scripts.md

clean:
	rm -f sample-scripts.md
