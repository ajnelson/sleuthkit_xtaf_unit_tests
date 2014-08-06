
TSK_LOADDB = deps/sleuthkit/build/bin/tsk_loaddb

all: \
  done_with_issue_21.flag

$(TSK_LOADDB): deps/sleuthkit
	pushd deps/sleuthkit && \
	  ./bootstrap && \
	  ./configure --disable-java --prefix=$$PWD/build && \
	  $(MAKE) && \
	  $(MAKE) install && \
	  popd

DRIVE2_TIME_FINAL.E01:
	echo "You should soft-link this disk image here." >&2
	exit 1

deps/sleuthkit: .gitmodules
	git submodule init
	git submodule sync
	git submodule update

done_with_issue_21.flag: issue_21.sh $(TSK_LOADDB) DRIVE2_TIME_FINAL.E01
	./issue_21.sh
	touch $@
