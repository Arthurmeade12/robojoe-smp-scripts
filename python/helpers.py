#!/usr/bin/env python
import sys

def corrupt(project):
  error('%s did not download properly. Please download manually.' % project)

def debug(msg):
  debug = False
  if debug is True: print(' \033[;1;34m]==>\033[;0;31m DEBUG:\033[;0m %s\033[;0m' % msg)

def error(errormsg):
  print(' ==>\033[;0;31m ERROR:\033[;0m %s\033[;0m' % errormsg)

def error_exit(errormsg, exitcode):
  code = int(exitcode) # Force to be an integer
  error(errormsg)
  sys.exit(code)

def out(msg):
  print(' \033[;1;32m==>\033[;0m %s\033[0m' % msg)

