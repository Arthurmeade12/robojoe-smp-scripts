#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034
### IMPORTANT : Order of JENKINS arrays must be parallel
### Alphabetical by JENKINS_NAMES
### DO NOT EDIT ABOVE THIS LINE
JENKINS_DIR='plugins'

JENKINS_NAMES=(
  'EssentialsX Dev'
  'Luckperms'
)

JENKINS_PATHS=(
  'jars/EssentialsX-'
  'bukkit/'
)

JENKINS_URLS=(
  'ci.ender.zone/job/EssentialsX'
  'ci.lucko.me/job/LuckPerms'
)
