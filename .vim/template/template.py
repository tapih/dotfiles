#! /usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import
from __future__ import print_function
from six.moves import range

import os, sys

from logging import getLogger, StreamHandler, FileHandler, Formatter
from logging import DEBUG, ERROR, INFO

# create logger
logger = getLogger(__name__)
logger.setLevel = (DEBUG)

# handler for console
stream_log = StreamHandler()
stream_log.setLevel(DEBUG)
stream_log.setFormatter(Formatter("%(asctime)s %(levelname)s %(message)s"))

# handler for file
file_log  = FileHandler(filename='log.txt')
file_log.setLevel(ERROR)
file_log.setFormatter(Formatter("%(asctime)s %(levelname)s %(message)s"))

# generate logger
logger.addHandler(stream_log)
logger.addHandler(  file_log)
