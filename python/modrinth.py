#!/usr/bin/env python
from helpers import out, error_exit, debug
from jsonfile import jsonfile
from pathlib import Path
import hashlib
import requests

class Modrinth:
    api_url = 'https://api.modrinth.com/v2'
    jsonconfig = jsonfile('modrinth.json')._dict
    mr_query_params = "?algorithm=sha512?multiple=false"
    headers = {
        'Content-Type': "application/json",
        'User-Agent': "arthurmeade12/robojoe-smp-scripts"
    }
    payload = """{
  "loaders": [
    "paper",
    "purpur"
  ],
  "game_versions": [
    "1.21.4"
  ]
}
"""
    def __init__(self, index):
        try:
            debug('Modrinth.json : ' + str(Modrinth.jsonconfig))
            self.name = Modrinth.jsonconfig[int(index)]['name']
            self.glob = Modrinth.jsonconfig[int(index)]['glob']
            self.fallback_hash = Modrinth.jsonconfig[int(index)]['fallback_hash']
        except OSError:
            error_exit('The file could not be read or is an invalid json.', 1)
        self.localfile = self.eval_glob()

    def eval_glob(self):
        globs = list(Path('.').glob(self.glob))
        match len(globs):
            case 0:
                return None
            case 1:
                return globs[0]
            case _:
                error_exit('The wildcard "' + self.glob + '" matches multiple files. Please     restrict it.', 1)

    def __str__(self):
        return self.name

    @staticmethod
    def sha256sum(self, _file):
        # Inspired by https://www.geeksforgeeks.org/hashlib-module-in-python/
        _buffer = 65536 # Arbitary buffer size of 64 kb
        sha256 = hashlib.sha256()
        with _file.read_bytes() as rawfile:
            while True:
                data = rawfile.read(_buffer)
                if not data: # If there is no more data
                    break
                sha256.update(data) # Update the sha256 object

        return sha256.hexdigest()

    def _exec(self):
        globs = self.eval_glob()
        out("Globs: " + str(type(globs)) + " : " + str(globs))
        if globs == None:
            # No localfile, fallback on fallback hash
            self.local_hash = self.fallback_hash
        else:
            # eval_glob() deals with (len(globs) > 1)
            self.local_hash = Modrinth.sha256sum(globs)
        self.receipt = requests.post(
            Modrinth.api_url + "/version_file/" + self.local_hash + "/update" + Modrinth.mr_query_params,
            headers=Modrinth.headers.json(),
            json=Modrinth.payload)
        out("Receipt : " + self.receipt)

