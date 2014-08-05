
all: check

check: \
  DRIVE2_TIME_FINAL.E01 \
  deps/sleuthkit \
  check-issue_21.sh

check-issue_21.sh: issue_21.sh
	./issue_21.sh

deps/sleuthkit:
	git submodule init
	git submodule update

DRIVE2_TIME_FINAL.E01:
	echo "You should soft-link this disk image here." >&2
	exit 1
