#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### IMPORTANT : Order of UNAVAILABLE arrays must be parallel
### Alphabetical by UNAVAILABLE_NAMES
### Note: unavailable.sh is intended for aiding the user in downloading projects that are either not machine-downloadable or not supported yet; for example from spigotmc.org.
### Note (continued): Do not attempt to hook up Hangar or Songoda(💀) or something to this file with UNAVAILABLE_COMMAND; make another and add your own definition to config.sh.
### DO NOT EDIT ABOVE THIS LINE

# The command to run on every UNAVAILABLE_URL.
# Typically `xdg-open` on most Linux distributions and `open` on macOS (Darwin)
UNAVAILABLE_COMMAND='xdg-open'

# Dummy, used for consistency with other sources
# Don't touch
UNAVAILABLE_DIR='.'

# The pretty name to display
UNAVAILABLE_NAMES=(
  'McXboxBroadcast'
)

# The URL to open in the user's web browser for manual download
UNAVAILABLE_URLS=(
  'https://github.com/MCXboxBroadcast/Broadcaster/releases'
)
