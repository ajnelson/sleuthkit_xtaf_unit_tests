#!/bin/bash

# https://github.com/ajnelson/sleuthkit/issues/13

set -x
set -e

source _pick_pythons.sh

bn="$(basename "$0")"
ERRLOG="$bn.err.log"

"$PYTHON2" issue_13.py --debug DRIVE2_TIME_FINAL.E01 2>"$ERRLOG"

"$PYTHON3" issue_13.py --debug DRIVE2_TIME_FINAL.E01 2>>"$ERRLOG"
