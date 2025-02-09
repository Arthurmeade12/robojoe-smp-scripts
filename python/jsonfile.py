#!/usr/bin/env python
import json
from pathlib import Path

class jsonfile:
    def __init__(self, relative_path):
        self.path = Path(__file__).parent/relative_path
        self.rawfile = open(self.path.resolve())
        self._dict = json.load(self.rawfile)

