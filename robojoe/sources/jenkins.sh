#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### Definition: DIR, NAMES, PATHS, URLS
### IMPORTANT : Order of JENKINS arrays must be parallel
### Alphabetical by JENKINS_NAMES
### DO NOT EDIT ABOVE THIS LINE

# The folder into which all project(s) in this file should be downloaded
JENKINS_DIR='plugins'

# The pretty name to display
JENKINS_NAMES=(
  'BKCommonLib Dev'
  'EssentialsX Dev'
  'GravestonesPlus Dev'
  'Luckperms'
  'MyWorlds Dev'
)

# ADVANCED:
# Some developers have multiple artifacts in each build on their Jenkins server. This string helps distinguish the particular file you want (it is grepped onto the list of artifacts)
# As long as the Jenkins server is only producing one artifact per build, this is not needed.
# Finding this string takes some time debugging the Jenkins API output with `curl` `jq` and `grep`.
# If you don't know what you're doing, leave this option blank
JENKINS_PATHS=(
   ''
  'jars/EssentialsX-'
  ''
  'bukkit/'
  ''
)

# The URL of the Jenkins server, with the job you want on the end
JENKINS_URLS=(
  'ci.mg-dev.eu/job/BKCommonLib'
  'ci.ender.zone/job/EssentialsX'
  'bencodez.com/job/GraveStonesPlus'
  'ci.lucko.me/job/LuckPerms'
  'ci.mg-dev.eu/job/MyWorlds'
)
