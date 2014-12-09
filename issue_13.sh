#!/bin/bash

# https://github.com/ajnelson/sleuthkit/issues/13

set -x
set -e

source _pick_pythons.sh

bn="$(basename "$0")"
ERRLOG="$bn.err.log"

"$PYTHON2" issue_13.py --debug issue_13.dfxml 2>"$ERRLOG"

"$PYTHON3" issue_13.py --debug issue_13.dfxml 2>>"$ERRLOG"
