
SHELL := /bin/bash

all: \
  done_with_issue_13.flag \
  done_with_issue_21.flag \
  done_with_issue_23.flag

tsk_built.flag: .gitmodules .git/modules/deps/sleuthkit/HEAD
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

dfxml_linked.flag: .gitmodules
	git submodule init
	git submodule sync
	git submodule update deps/dfxml
	touch $@

.git/modules/deps/sleuthkit/HEAD: .gitmodules
	git submodule init
	git submodule sync
	git submodule update deps/sleuthkit

done_with_issue_13.flag: issue_13.sh issue_13.py tsk_built.flag dfxml_linked.flag DRIVE2_TIME_FINAL.E01
	./issue_13.sh
	touch $@

done_with_issue_21.flag: issue_21.sh tsk_built.flag DRIVE2_TIME_FINAL.E01
	./issue_21.sh
	touch $@

done_with_issue_23.flag: issue_23.sh issue_23.py tsk_built.flag dfxml_linked.flag DRIVE2_TIME_FINAL.E01
	./issue_23.sh
	touch $@
