#!/usr/bin/env python
import json, os
from helpers import error

class jsonfile:
    def __init__(self, relative_path):
        self.path = os.path.dirname(__file__) + '/' + relative_path
        self.rawfile = open(self.path)
        self._dict = json.load(self.rawfile)
        self.rawfile.close()

