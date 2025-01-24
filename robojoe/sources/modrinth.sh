#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### Definition: variables API_URL, BACKUP, DIR, NAMES, PAYLOAD, and WILDCARDS
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
  ### All as of 12/22/24 unless otherwise noted
  '624f658421ec7eaf5f0dcc0fdd0ddc5cd2fc778c063c664f1140940ee25e69c5b5bcb721cdd70c7bb9f543346d70c2547e18181c651e451d67627f10f95670a5' # 1/13/2025
  '3e9d241adafe1d7979c83ab2796d37f6aee1bcc9373cdf1404d6107df5157a0a31dbea642ffb8aeab018e9ab48fe648d2161a069c346063ea840873300dbd573'
  '47997111bbf8454d26c7d03c9243e98b5f59bb020f89561202e742ff1af4f6ad96ae0a94e14fdda0711b54851c85fd5b5d754b1f0eb55236fa3f1df1c9622573'
  '0874f449965ec28a1ec1453a4aafc6da80e1647ec46b87559540d57047603f6b07f83d69b602f049475756e38f9148dbd964f668341cbb30b7ebd09345c97aad'
  'cd6dcfcb77ed8f88b60ca6e277bd12a13e4304c76f6ea7d497bf6e47ee2ceef2f831c24d4dc59a0b75e810fa62dbaa714efa91ad7c9b02fe7d627511533af217'
  '0f2936de12b9c8003ab95bad54c92af31ffb53588ca3619a0910991c566275422cdead4af6432a1a8fbb7645766065588cb4bc914b34473bd0e0c88205c54701'
  '6dcd2036740f44cf7cfbe72d829601abccaa6e33c79804df183e516ee1e0fecd70c60a023b1ff7608e41de05b8af84707479dec7ae67af8aa9554f0413966459'
  'b098d0c5d8d1d9e1536bec641d9f9f57b6122870adae1ea4f795d44fcba4bd3e22b08a94dee37a659a66d494c87e414f42c8fe02ce8b96830025ec9cf06ceb0c'
  'a7d299dd35712ac4a2ec5d93e283917e7a95679a5977b16dbc701694d17b3371aabe07a6019424dd4a1810095695f54b829b773915fc3879b0cd21165d42c613'
  '80fd9e4d83e201b8cb26e5bf390c5023f567c2d3551adf3e03eb5adb5215d810b883d3b4589526a5787a52b90420af9d3498505f4077115100424a19ebc8260c'
  'b1796c42589042beb4938044d60a340f429c3f5646fc891015dcf30a34f2ecdb784735a62a0522d17f85db8d7c146baf064c0ad6eea2866799b64f03155e5048'
  'e04cd2ea9c141717a276cf6467fe745ef5e2d5b36538016a107fc1264938374e0180cb0d95e7954221c77a8d381910da977685e24dfbd3ff2e74bb73bafeee46'
  'e89931ae6341b30b1cf7b223d2cd9c90b6403937c8be9b9ebd16fefa9c774d513c25cce36aa192713669163aae2019b24422b6b2b03f223720745621547ea377'
  '85d5ec6001d73be013a77adf16b54f367a47314e6b849ca78cc575c9751637fec9e7215a12bbaa4d430d40c40eb6b8c877f87f81f28ce2507c75918f82bb883f'
  '5ab0d74e7a60654567b19a9fbfb7c2d680a5bc7ffd53879006cfd38604a5576d103470e7278a37480f0593933de129d849539145a5f182ff39d547d402b097fe'
  '91144ad45e73f1ae115aa6cfdd1844eefc06d2c7abf8f248ab8c33f4f3fd3cecc468d4ad7209842641ec092a31c90d14ea42893e2da00f1cae297fc109a458ce'

)

# The folder into which all project(s) in this file should be downloaded
MODRINTH_DIR='plugins'

# The pretty name to display
MODRINTH_NAMES=(
  'Bentobox' # 0
  'Chunky' # 1
  'Chunky Border' # 2
  'CoreProtect' # 3
  'Craftbook' # 4
  'DiscordSRV' # 5
  'GriefPrevention' # 6
  'Grim Anticheat' # 7
  'Maintenance' # 8
  'mclo.gs' # 9
  'Pl3xMap' # 10
  'Simple Voice Chat' # 11
  'Simple Voice Chat Discord Bridge' # 12
  'ViaBackwards' # 13
  'ViaVersion' # 14
  'Worldedit' # 15
)

# A tricky variable. This is the payload sent to Modrinth for the projects and versions you want.
# MUST be a valid JSON
# Whitespace here is strict; do not add or remove spaces or newlines
# The projects you want must have versions in this array for them to be downloaded
MODRINTH_PAYLOAD='{
  "loaders": [
    "paper",
    "purpur"
  ],
  "game_versions": [
    "1.20",
    "1.20.6",
    "1.21",
    "1.21.1",
    "1.21.3",
    "1.21.4"
  ]
}
'
# 1.20 for mclo.gs
# 1.20.6 for CoreProtect
# 1.21.1 for DriveBackupV2, GriefPrevention
# 1.21.3 for Simple Voice Chat Discord Bridge, WorldEdit
# Paper for Chunky, Chunky Border, Geyser, GriefPrevention (maybe? inconsistent), Maintenance, ViaBackwards, ViaVersion, Worldedit

# The filename whose sha512 hash download.sh compares to Modrinth's
# BUG: `find` does not like ${MINECRAFT_MINOR} or ${MINECRAFT_MAJOR} in this array
MODRINTH_WILDCARDS=(
  'BentoBox-*.jar'
  'Chunky-Bukkit-1.*.*.jar'
  'ChunkyBorder-Bukkit-1.*.*.jar'
  'CoreProtect-*.*.jar'
  'craftbook-bukkit-*.*.*.jar'
  'DiscordSRV-Build-1.*.jar'
  'GriefPrevention-*.*.*.jar'
  'grimac-2.*.*.jar'
  'Maintenance-*.*.jar'
  'mclogs-bukkit-*.*.jar'
  'Pl3xMap-*-*.jar' # Would use "Pl3xMap-${MINECRAFT_MINOR}-*.jar", but `find` doesn't like this glob
  'voicechat-bukkit-*.*.*.jar'
  'voicechat-discord-paper-*.*.*.jar'
  'ViaBackwards-*.*.*.jar'
  'ViaVersion-*.*.*.jar'
  'worldedit-bukkit-*.*.*.jar'
)

