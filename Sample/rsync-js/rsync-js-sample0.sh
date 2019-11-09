#!/bin/bash
JSTOOL_DIR="."
if jsrun --use-main --arguments "${JSTOOL_DIR}/Resource/Sample/rsync-js/rsync-js-sample0.json " ${JSTOOL_DIR}/Resource/Tools/rsync.js ; then
	exit 0 ;
else
	exit 1 ;
fi

