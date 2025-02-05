#!/usr/bin/env python
import glob, json
from helpers import out, error_exit
class Modrinth:
    api_url = 'https://api.modrinth.com/v2'
    def __init__(self, name):
        self.name = name

    def populate(self, jsonconfig):
        try:
            self.mrjson = json.load(jsonconfig)
            self.wildcard = self.mrjson["projects"][self.name]["glob"]
            self.backup_bash = self.mrjson["projects"][self.name]["glob"]
            out("Wildcard : " + self.wildcard)
        except OSError:
            error_exit('The file could not be read or is an invalid json.', 1)

    def eval_glob(self,):
        globs = glob.glob(self.wildcard)
        match len(globs):
            case 0:
                error_exit('The wildcard "' + self.wildcard + '" did not match any files. ', 1)
            case 1:
                self.localfile = str(globs[0])
                out(self.localfile)
            case _:
                error_exit('The wildcard "' + self.wildcard + '" matches multiple files. Please     restrict it.', 1)

    def __str__(self):
        return self.name

    def download(self,):
        out("Success")
