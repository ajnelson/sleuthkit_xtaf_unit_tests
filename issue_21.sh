#!/bin/bash

# https://github.com/ajnelson/sleuthkit/issues/21

set -x
set -e

bn="$(basename "$0")"
ERRLOG="$bn.err.log"
rm -f "$bn.db"
#When this runs without printing "Error:", it's done.
deps/sleuthkit/build/bin/tsk_loaddb -d "$bn.db" DRIVE2_TIME_FINAL.E01 2>"$ERRLOG"
test $(grep 'Error:' "$ERRLOG" | wc -l) -eq 0
