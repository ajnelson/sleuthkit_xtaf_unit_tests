#!/usr/bin/env python3

"""
Call ils on every file.  Check that the name is being printed.
"""

__version__ = "0.0.1"

import logging
import os
import sys
import subprocess

_logger = logging.getLogger(os.path.basename(__file__))
logging.basicConfig(level=logging.DEBUG)

import Objects

for (event, obj) in Objects.iterparse(sys.argv[1]):
    if not isinstance(obj, Objects.FileObject):
        continue

    #Just do regular files and directories.
    if obj.nametype not in ["r", "d"]:
        continue

    if obj.inode is None:
        raise ValueError("The inode is necessary for this test.  This object didn't have it: %r." % obj)

    _logger.debug("Filename: %r." % obj.filename)

    partition_offset_in_bytes = None
    if obj.volume_object:
        partition_offset_in_bytes = obj.volume_object.partition_offset
    else:
        partition_offset_in_bytes = 0

    cmd = ["deps/sleuthkit/build/bin/ils"]
    cmd.append("-o")
    cmd.append(str(partition_offset_in_bytes // 512))
    cmd.append("-f")
    cmd.append("xtaf")
    cmd.append(sys.argv[1])
    cmd.append(str(obj.inode))
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    sys.stdout.write(p.read())
    p.wait()
