
import logging
import os

import Objects

_logger = logging.getLogger(os.path.basename(__file__))

def main():
    global args
    last_file_iter_no = None
    for (iter_no, (event, obj)) in enumerate(Objects.iterparse(args.disk_image, fiwalk="deps/sleuthkit/build/bin/fiwalk")):
        if not isinstance(obj, Objects.FileObject):
            continue
        last_file_iter_no = iter_no

        if obj.atime is None:
            continue
        if not obj.atime.prec in (2, "2", "2s"):
            raise ValueError("Precision of atime in XTAF is 2 seconds.")
        _logger.debug("Atime precision good:  File %r." % obj.filename)

    if last_file_iter_no is None:
        raise ValueError("Did not encounter any files.")
    _logger.info("Done.")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--debug", action="store_true")
    parser.add_argument("disk_image")
    args = parser.parse_args()

    logging.basicConfig(level=logging.DEBUG if args.debug else logging.INFO)

    main()
