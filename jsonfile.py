#!/usr/bin/env python
import json, os

class jsonfile:
    def __init__(self, relative_path):
        self.value = json.load(os.dirname(__name__) + relative_path)
