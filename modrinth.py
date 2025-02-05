#!/usr/bin/env python
import glob
from helpers import out, error
class Modrinth:

  def __init__(self, name):
    self.name = name

  def eval_glob(self, wildcard):
    globs = glob.glob(wildcard)
    match len(globs):
      case 0:
        error('The wildcard "' + wildcard + '" did not match any files. ')
      case 1:
        self.localfile = str(globs[0])
      case _:
        error('The wildcard "' + wildcard + '" matches multiple files. Please restrict it.')

  def download(self,):
    out("Success")
