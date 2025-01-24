#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### Definition: variables API_URL, BACKUPS, NAMES, PAYLOAD, and WILDCARDS
### IMPORTANT : Order of MODRINTH arrays must be parallel
### Alphabetical by MODRINTH_NAMES
### DO NOT EDIT ABOVE THIS LINE

# ADVANCED:
# The API URL, which must understand Modrinth API, to which all requests will be sent
# Note: https://curserinth-api.kuylar.dev/ may work for accessing Curseforge through the Modrinth API, but this is untested and unsupported by download.sh and the developer of Curserinth, who has archived their project.
# Don't change if you don't know what you're doing
MODRINTH_API_URL='https://api.modrinth.com/v2'

# The sha512 hash of any jar from the Modrinth project you want. This is only used when downloading a Modrinth project for the first time, or if the download was deleted.
MODRINTH_BACKUPS=(
  #'85d5ec6001d73be013a77adf16b54f367a47314e6b849ca78cc575c9751637fec9e7215a12bbaa4d430d40c40eb6b8c877f87f81f28ce2507c75918f82bb883f'
  #'5ab0d74e7a60654567b19a9fbfb7c2d680a5bc7ffd53879006cfd38604a5576d103470e7278a37480f0593933de129d849539145a5f182ff39d547d402b097fe'
)

# The folder into which all projects in this file should be downloaded
MODRINTH_DIR='plugins'

# The pretty name to display
MODRINTH_NAMES=(
  #'ViaBackwards'
  #'ViaVersion'
)

# A tricky variable. This is the payload sent to Modrinth for the projects and versions you want.
# MUST be a valid JSON
# Whitespace here is strict; do not add or remove spaces or newlines
# The projects you want must have versions in this array for them to be downloaded
MODRINTH_PAYLOAD='{
  "loaders": [
    "purpur"
  ],
  "game_versions": [
    "1.20.6",
    "1.21.4"
  ]
}
'

# The filename whose sha512 hash download.sh compares to Modrinth's
# BUG: `find` does not like ${MINECRAFT_MINOR} or ${MINECRAFT_MAJOR} in this array
MODRINTH_WILDCARDS=(
  'ViaBackwards-*.*.*.jar'
  'ViaVersion-*.*.*.jar'
)
