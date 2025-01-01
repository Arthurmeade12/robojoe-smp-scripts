#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034
### DO NOT EDIT ABOVE THIS LINE

CURL_ARGS='-JlOf# --clobber'
MINECRAFT_MAJOR='1.21'
MINECRAFT_MINOR='1.21.4'
OPTIONAL_SOURCES=('geyser.sh' 'jenkins.sh' 'modrinth.sh' 'purpur.sh')
TIMESTAMP_FILE='.timestamp'
UPDATE_MODE='true' # If false, downloads every project regardless of whether it's up to date or not
DEBUG='false' # Very verbose

declare -A UNAVAILABLE=(
  # ['Display Name']='URL to open for a human update check'
  #['GraveStonesPlus']='https://www.spigotmc.org/resources/gravestonesplus.95132/updates'
  ['mcxboxbroadcast']='https://github.com/MCXboxBroadcast/Broadcaster/releases'
  #['MyWorlds']='https://www.spigotmc.org/resources/myworlds.39594/updates'
  ['Vault']='https://dev.bukkit.org/projects/vault/files'
  ['VaultChatFormatter']='https://www.spigotmc.org/resources/vaultchatformatter.49016/'
)

TARGET_DIR="${HOME}/Github/robojoe-smp-scripts/robojoe"
# Determines location of everything except checks.sh, config.sh, and helpers.sh, which must be in same dir as download.sh

### OPTIONAL SOURCE DEFINITIONS
### All vars are expected to be prefixed with the basename of the script they are in, minus the '.sh' part.
### All variables defined here are required to be arrays of the same length as all other arrays in that file, except those prefixed with the symbol '@', which will be treated as strings.

GEYSER_DEFINITION=(
  '@API_URL'
  'NAMES'
  'PROJECTS'
)

JENKINS_DEFINITION=(
  'NAMES'
  'PATHS'
  'URLS'
)

MODRINTH_DEFINITION=(
  '@API_URL'
  'BACKUPS'
  'NAMES'
  '@PAYLOAD'
  'WILDCARDS'
)

PURPUR_DEFINITION=(
  '@API_URL'
  'NAMES'
  'PROJECTS'
  'WILDCARDS'
)

# Add your own definitions here
