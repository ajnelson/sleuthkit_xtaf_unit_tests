#!/bin/bash

#This test checks for a segfault.

#set -e #Don't disable error-halts.
set -x

test -r DRIVE2_TIME_FINAL.E01

#Cleanup from last test
rm -rf build test.db
rm -rf tsk3 #An artifact of checkouts
git checkout -- .

./bootstrap
./configure --disable-java --prefix=$PWD/build
make -j || exit 125   #We're looking for a segfault, not a build failure.
make install

#Segfault here -> 'bad' commit.  Any other execution = 'good' commit, for the purpose of this test.
build/bin/tsk_loaddb -d test.db DRIVE2_TIME_FINAL.E01
rc=$?

echo "NOTE:$(basename $0):Resetting tsk3/ dir (if it's there) for next git-bisect checkout." >&2
rm -rf tsk3
git checkout -- .

exit $rc
