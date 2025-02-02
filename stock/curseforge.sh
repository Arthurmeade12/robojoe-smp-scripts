#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### IMPORTANT : Order of CURSEFORGE arrays must be parallel
### Alphabetical by CURSEFORGE_NAMES
### DO NOT EDIT ABOVE THIS LINE

# ADVANCED:
# The API URL, which must understand Modrinth API, to which all requests will be sent
# Note: https://curserinth-api.kuylar.dev/ may work for accessing Curseforge through the Modrinth API, but this is untested and unsupported by download.sh and the developer of Curserinth, who has archived their project.
# Don't change if you don't know what you're doing
CURSEFORGE_API_URL='https://api.curseforge.com/v1'

# The folder into which all projects in this file should be downloaded
CURSEFORGE_DIR='plugins'

# The pretty name to display
CURSEFORGE_NAMES=(
  #'Vault'
)

# The ID of the Curseforge Project. Crucial for interacting with the API.
# Should be in the description of the Curseforge page online
CURSEFORGE_IDS=(
  #'33184'
)

# The filename whose sha1 hash download.sh compares to Curseforge's
# BUG: `find` does not like ${MINECRAFT_MINOR} or ${MINECRAFT_MAJOR} in this array
CURSEFORGE_WILDCARDS=(
  #'Vault.jar'
)
