#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034
### IMPORTANT : Order of PURPUR arrays must be parallel
### Alphabetical by PURPUR_NAMES
### DO NOT EDIT ABOVE THIS LINE

PURPUR_API_URL='https://api.purpurmc.org/v2/'

PURPUR_DIR='.'

PURPUR_NAMES=(
  'Purpur'
)

PURPUR_PROJECTS=(
  'purpur'
)

PURPUR_WILDCARDS=(
  'purpur-1.*.*.jar' #"purpur-${MINECRAFT_MINOR}-*.jar"
)
