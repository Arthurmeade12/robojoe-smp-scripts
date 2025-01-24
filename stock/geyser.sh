#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### IMPORTANT : Order of GEYSER arrays must be parallel
### Alphabetical by GEYSER_NAMES
### DO NOT EDIT ABOVE THIS LINE

# ADVANCED:
# The API URL, which must understand Geyser Download API, to download from
# Don't touch if you don't know what you're doing
GEYSER_API_URL='https://download.geysermc.org/v2'

# The folder into which all project(s) in this file should be downloaded
GEYSER_DIR='plugins/'

# The pretty name to display
GEYSER_NAMES=(
  #'Floodgate'
  #'Geyser'
)

# The technical name to send to the Geyser Download API
GEYSER_PROJECTS=(
  #'floodgate'
  #'geyser'
)
