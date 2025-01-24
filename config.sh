#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034
### Definition: OPTIONAL_SOURCES, UPDATE_MODE, CURL_ARGS, MINECRAFT_MAJOR, MINECRAFT_MINOR, VERBOSE
### DO NOT EDIT ABOVE THIS LINE

# Used for downloading the file only, not interacting with the online APIs
CURL_ARGS='-JlOf# --clobber'

# If true, only downloads projects if they have been updated.
# If false, downloads every project regardless of how recently it has been updated.
# Jenkins does not respect this option (TODO)
UPDATE_MODE='true'

# Very verbose. Overriden by -v at command line
VERBOSE='false'

# How many seconds to wait for the user to answer a yes or no question
WAIT='10'

### SERVER DEFINITIONS
### The first element of the array shall be the path where the optional sources and downloaded files are to be located
### All remaining elements are optional sources used in that server
### Any custom optional source must be defined at the end of config.sh

# List of optional sources used on this server
ROBOJOE=(
  'geyser.sh'
  'jenkins.sh'
  'modrinth.sh'
  'purpur.sh'
  'unavailable.sh'
)

# Path to find optional sources and to download files
ROBOJOE_PATH="${HOME}/Github/robojoe-smp-scripts/robojoe"

# Used internally for dynamic file-grepping and for interacting with some APIs
ROBOJOE_VERSION='1.21.4'

### OPTIONAL SOURCE DEFINITIONS
### All vars are expected to be prefixed with the basename of the script they are in, minus the '.sh' part.
### All variables defined here are required to be arrays of the same length as all other arrays in that file, except those prefixed with the symbol '@', which will be treated as strings.
### All optional sources must contain *name*_DIR for their execution
### Additionally, please add the function *name*_exec to your optional source
### See examples at the beginning of lib/checks.sh


