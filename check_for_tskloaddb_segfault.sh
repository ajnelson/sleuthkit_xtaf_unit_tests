#!/bin/bash

#This test checks for a segfault.

#set -e #Don't disable error-halts.
set -x

IMAGE=../../DRIVE2_TIME_FINAL.E01
if [ ! -r "$IMAGE" ]; then
  echo "ERROR:$(basename $0):Soft-link the disk image into the test superproject." >&2
  exit 1
fi

#Cleanup from last test
rm -rf build test.db
if [ -d tsk3 ]; then
  rm -rf tsk3 #An artifact of checkouts
  git checkout -- tsk3
fi

./bootstrap
./configure --disable-java --prefix=$PWD/build
make -j || exit 125   #We're looking for a segfault, not a build failure.
make install

build/bin/tsk_loaddb -d test.db "$IMAGE"
rc=$?

echo "NOTE:$(basename $0):Resetting tsk3/ dir (if it's there) for next git-bisect checkout." >&2

if [ -d tsk3 ]; then
  rm -rf tsk3
  git checkout -- tsk3
fi

#Segfault from tsk_loaddb -> 'bad' commit.  Any other exit status -> 'good' commit, for the purpose of this test.
if [ $rc -eq 139 ]; then
  exit 1
else
  exit 0
fi
