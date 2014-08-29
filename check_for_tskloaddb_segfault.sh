#!/bin/bash

#This test checks for a segfault.

set -e
set -x

test -r DRIVE2_TIME_FINAL.E01

#Cleanup from last test
rm -rf build test.db

./bootstrap
./configure --disable-java --prefix=$PWD/build
make -j || exit 125   #We're looking for a segfault, not a build failure.
make install

#Segfault here -> 'bad' commit.  Any other execution = 'good' commit, for the purpose of this test.
build/bin/tsk_loaddb -d test.db DRIVE2_TIME_FINAL.E01
