This repository just contains unit tests for developing the TSK XTAF extension.


## git-bisect reminders

To run a git-bisect on the current development head (`for_sleuthkit-xtafb2`) and a known-not-failing commit (let's say all the way back to `sleuthkit-4.0.2`), execute a script set up for a git-bisect run (e.g. this directory's `check_for_tskloaddb_segfault.sh`):

    cd deps/sleuthkit
    git bisect start for_sleuthkit-xtafb2 sleuthkit-4.0.2
    git bisect run ../../check_for_tskloaddb_segfault.sh
    git bisect reset
