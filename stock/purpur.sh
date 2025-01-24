#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### IMPORTANT : Order of PURPUR arrays must be parallel
### Alphabetical by PURPUR_NAMES
### DO NOT EDIT ABOVE THIS LINE

# ADVANCED:
# The API URL, which must understand Purpur Download API, to download from
# Don't touch if you don't know what you're doing
PURPUR_API_URL='https://api.purpurmc.org/v2/'

# The folder into which all project(s) in this file should be downloaded
# '.' means the folder itself; so one folder above what 'plugins' would be
PURPUR_DIR='.'

# The pretty name to display
PURPUR_NAMES=(
  #'Purpur'
)

# The technical name to send to the Purpur Download API
PURPUR_PROJECTS=(
  #'purpur'
)

# The filename whose md5 hash is compared to purpurmc.org's
# BUG: `find` does not like ${MINECRAFT_MINOR} or ${MINECRAFT_MAJOR} in this array
PURPUR_WILDCARDS=(
  #'purpur-1.*.*.jar' #"purpur-${MINECRAFT_MINOR}-*.jar"
)
