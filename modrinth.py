#!/usr/bin/env python
import glob
from helpers import out
class Modrinth:
  def __init__(self, name, wildcard):
    self.name = name
    self.localfile = glob.glob(self.wildcard)
  def download(self,):
    out('String :' + self.name)
    out('Local File': + self.localfile)

