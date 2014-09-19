#!/bin/bash

# https://github.com/ajnelson/sleuthkit/issues/21

set -x
set -e

bn="$(basename "$0")"
ERRLOG="$bn.err.log"
#When this runs without printing "Error:", it's done.
python3.3 issue_23.py DRIVE2_TIME_FINAL.E01 2>"$ERRLOG"

echo "Test not yet complete." >&2
exit 1

test $(grep 'ERROR:' "$ERRLOG" | wc -l) -eq 0
