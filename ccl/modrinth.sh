#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034
### Definition: variables PAYLOAD, NAMES, and BACKUPS
### IMPORTANT : Order of MODRINTH arrays must be parallel
### Alphabetical by MODRINTH_NAMES
### DO NOT EDIT ABOVE THIS LINE

MODRINTH_API_URL='https://api.modrinth.com/v2'

MODRINTH_BACKUP=(
  ### All as of 12/22/24
  '3e9d241adafe1d7979c83ab2796d37f6aee1bcc9373cdf1404d6107df5157a0a31dbea642ffb8aeab018e9ab48fe648d2161a069c346063ea840873300dbd573'
  '0874f449965ec28a1ec1453a4aafc6da80e1647ec46b87559540d57047603f6b07f83d69b602f049475756e38f9148dbd964f668341cbb30b7ebd09345c97aad'
  'b1796c42589042beb4938044d60a340f429c3f5646fc891015dcf30a34f2ecdb784735a62a0522d17f85db8d7c146baf064c0ad6eea2866799b64f03155e5048'
  '85d5ec6001d73be013a77adf16b54f367a47314e6b849ca78cc575c9751637fec9e7215a12bbaa4d430d40c40eb6b8c877f87f81f28ce2507c75918f82bb883f'
  '5ab0d74e7a60654567b19a9fbfb7c2d680a5bc7ffd53879006cfd38604a5576d103470e7278a37480f0593933de129d849539145a5f182ff39d547d402b097fe'
  '91144ad45e73f1ae115aa6cfdd1844eefc06d2c7abf8f248ab8c33f4f3fd3cecc468d4ad7209842641ec092a31c90d14ea42893e2da00f1cae297fc109a458ce'
)

MODRINTH_NAMES=(
  'Chunky' # 0
  'CoreProtect' # 1
  'Pl3xMap' # 2
  'ViaBackwards' # 3
  'ViaVersion' # 4
  'Worldedit' # 5
)

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
# 1.20.6 for CoreProtect
# Paper for ViaBackwards, ViaVersion

MODRINTH_WILDCARDS=(
  'Chunky-Bukkit-1.*.*.jar'
  'CoreProtect-*.*.jar'
  'Pl3xMap-*-*.jar' # Would use "Pl3xMap-${MINECRAFT_MINOR}-*.jar", but `find` doesn't like this glob
  'ViaBackwards-*.*.*.jar'
  'ViaVersion-*.*.*.jar'
  'worldedit-bukkit-*.*.*.jar'
  'abcmouse.com'
)
