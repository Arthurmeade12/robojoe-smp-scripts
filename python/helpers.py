#!/usr/bin/env python
import sys

def corrupt(project):
  error('%s did not download properly. Please download manually.' % project)

def error(errormsg):
  print(' \033[;1;31m==>\033[;0;31m ERROR:\033[;0m %s\033[;0m' % errormsg)

def error_exit(errormsg, exitcode):
  code = int(exitcode) # Force to be an integer
  error(errormsg)
  sys.exit(code)

def out(msg):
  print(' \033[;1;32m==>\033[;0m %s\033[0m' % msg)

def print_help():
  print('''Usage: download.sh [options] <server(s)>
The server(s) must be defined in config.sh.

Options:
  -h : Display this help message
  -v : Be verbose (debug)

Error Codes:
  0 : Success
  1 : General Failure
  2 : Unrecognized command line option
  3 : A required source is missing from lib/ (reclone from Github to fix)
  4 : A command this script utilized is not installed on your system
  5 : Incompatible shell (must be Bash > 3)
  6 : The target directory cannot be created or written to (fix permissions)
''')
