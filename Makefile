
SHELL := /bin/bash

all: \
  done_with_issue_21.flag \
  done_with_issue_23.flag

tsk_built.flag: .git/modules/deps/sleuthkit/HEAD
	rm -f $@
	pushd deps/sleuthkit && \
	  ./bootstrap && \
	  ./configure --disable-java --prefix=$$PWD/build && \
	  $(MAKE) && \
	  $(MAKE) install && \
	  popd
	touch $@

DRIVE2_TIME_FINAL.E01:
	echo "You should soft-link this disk image here." >&2
	exit 1

Objects.py: .git/modules/deps/dfxml/HEAD

.git/modules/deps/dfxml/HEAD: .gitmodules
	git submodule init
	git submodule sync
	git submodule update deps/dfxml

.git/modules/deps/sleuthkit/HEAD: .gitmodules
	git submodule init
	git submodule sync
	git submodule update deps/sleuthkit

done_with_issue_21.flag: issue_21.sh tsk_built.flag DRIVE2_TIME_FINAL.E01
	./issue_21.sh
	touch $@

done_with_issue_23.flag: issue_23.sh issue_23.py tsk_built.flag Objects.py DRIVE2_TIME_FINAL.E01
	./issue_23.sh
	touch $@
