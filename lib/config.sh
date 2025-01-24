#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034
### DO NOT EDIT ABOVE THIS LINE

### More useful options

OPTIONAL_SOURCES=('geyser.sh' 'jenkins.sh' 'modrinth.sh' 'purpur.sh' 'unavailable.sh')
UPDATE_MODE='true' # If false, downloads every project regardless of whether it's up to date or not

### Advanced options

CURL_ARGS='-JlOf# --clobber' # Used for downloading the file only, not interacting with the online APIs
DEBUG='false' # Very verbose
MINECRAFT_MAJOR='1.21' # Used internally for dynamically changing jar names
MINECRAFT_MINOR='1.21.4' # Used internally for dynamically changing jar names, as well as for purpur.sh

TARGET_DIR="${HOME}/Github/robojoe-smp-scripts/robojoe"
# Determines location of everything except checks.sh, config.sh, and helpers.sh, which must be in same dir as download.sh

### OPTIONAL SOURCE DEFINITIONS
### All vars are expected to be prefixed with the basename of the script they are in, minus the '.sh' part.
### All variables defined here are required to be arrays of the same length as all other arrays in that file, except those prefixed with the symbol '@', which will be treated as strings.
### All optional sources must contain *name*_DIR for their execution
### See examples at the beginning of checks.sh



# Add your own definitions here
