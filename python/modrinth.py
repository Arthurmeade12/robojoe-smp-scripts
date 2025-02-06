#!/usr/bin/env python
import glob
from helpers import out, error_exit, debug
from jsonfile import jsonfile

class Modrinth:
    api_url = 'https://api.modrinth.com/v2'
    jsonconfig = jsonfile('modrinth.json')._dict
    def __init__(self, index):
        try:
            debug('Modrinth.json : ' + Modrinth.jsonconfig)
            self.name = Modrinth.jsonconfig[int(index)]['name']
            self.glob = Modrinth.jsonconfig[int(index)]['glob']
            self.fallback_hash = Modrinth.jsonconfig[int(index)]['fallback_hash']
        except OSError:
            error_exit('The file could not be read or is an invalid json.', 1)
        self.localfile = self.eval_glob()

    def eval_glob(self):
        globs = glob.glob(self.glob)
        match len(globs):
            case 0:
                error_exit('The wildcard "' + self.glob + '" did not match any files. ', 1)
            case 1:
                self.localfile = globs[0]
            case _:
                error_exit('The wildcard "' + self.glob + '" matches multiple files. Please     restrict it.', 1)

    def __str__(self):
        return self.name

    def download(self):
        out("Success")
