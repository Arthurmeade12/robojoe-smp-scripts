#!/usr/bin/env bash
set -u
TARGET_DIR="${TARGET_DIR:="$(dirname "${0}")"}"
CURL_ARGS='-JlOf#' # This variable is unquoted when expanded; word splitting will occur

# Spigot:
# - Skoice
# - GravestonesPlus
# - GrimAC


ESSENTIALSX=(
  # Filename greps
  'EssentialsX-'
  'EssentialsXDiscord-'
  #'EssentialsXDiscordLink-'
)
GEYSER=(
  # Geyser project names
  'geyser'
  'floodgate'
)
declare -A JENKINS=( # ['Jenkins base urls']='filename string to grep'
  ['jenkins.crazycrew.us/job/Pl3xMap-Mobs']='' # Pl3xmap-mobs
  ['jenkins.crazycrew.us/job/Pl3xMap-Banners']='' # Pl3xmap-banners
  ['jenkins.crazycrew.us/job/Pl3xMap-Signs']='' # Pl3xmap-signs
  ['jenkins.crazycrew.us/job/Pl3xMap-Warps']='' # Pl3xmap-warps
  ['jenkins.crazycrew.us/job/Pl3xMap-Claims']='' # Pl3xmap-Claims
  ['ci.dmulloy2.net/job/ProtocolLib']='' # Protocollib
  ['ci.lucko.me/job/LuckPerms']='bukkit/' # Luckperms
)
declare -A CURSEFORGE=(
  # [Project ID]='wanted version'
  [31055]=1.20.2 # Craftbook
  [322882]=1.20.4 # Deadchest
  #[33184]=1.16 # Vault # Causing problems. Rarely updates anyway
)
MODRINTH=(
  # 'sha1 of any file from the wanted project'
  #'cc4eecf54bba5f47a55d9e6bc28329edbea90517' # BentoBox # Disabled for now - we're not using it and it's heavy
  'd7eec4b81240739ad6aec537ac42c772647b56de' # CoreProtect
  '2b308cbae2ffaa50be612b51d80bd91a7341b65c' # ViaBackwards
  'bf503af2778cafe8621d5e3ba67ded95ca034058' # Maintenance
  '4112b0e304b5eeb9f36537119aac46f3f7fa44c1' # multiverse-signportals
  'd5cf3fca6d78e4c91128bf3c0418136f011a0017' # multiverse-core
  '83823933559b4bb8b2fde670f12220432b96d04a' # Terra
  'e351dd6f09eda6703575776a2232d759352cd7b6' # multiverse-portals
  '29b2bf30efaab24aac0c3f147fbe9d13fb63436d' # Chunky
  '741ebb4815dfc51147e70048356bb93be7896399' # multiverse-inventories
  '4dd02f707307efa7db50de6cea707c1c0a5b6eeb' # multiverse-netherportals
  'cf627fe7f646d228d7d6ee47acf34f4567f7a8c4' # worldedit
  '2e5e2baa7ac26b53d334d25771b87716adae4e8c' # Pl3xMap
  '13ae61a3a4beb3e7d00f6f7763136f336f58ff6d' # ViaVersion
)
#shellcheck disable=SC2034 # TODO
HANGAR=(
  #'fe09acd84d030f0e2e9e7440e0df5a9202f2e899' # harderdespawn
  #'4d6ba088d1017b5e2850adb9e0e3ab1203db5dc6' # Grim
)

PAYLOAD='{
  "loaders": [
    "paper",
    "purpur"
  ],
  "game_versions": [
    "1.20.1",
    "1.20.2",
    "1.20.4"
  ]
}
'
# 1.20.2 is max required by Coreprotect
# 1.20.1 is max version of EssentialsX & Maintenance
# Paper needed by more plugins than not (even though we run purpur)

if ! cd "${TARGET_DIR}"
then
  printf "\033[;1;31m%s%s%s\033[;0m" 'The target directory ' "${TARGET_DIR}" ' does not exist Aborting '
  exit 1
fi

# Purpur

curl ${CURL_ARGS} 'https://api.purpurmc.org/v2/purpur/1.20.4/latest/download'

# Normal modrinth project loop
for PROJECT in "${MODRINTH[@]}"
do
  curl -sX POST "https://api.modrinth.com/v2/version_file/${PROJECT}/update" -H "Content-Type: application/json" --data-binary "${PAYLOAD}" | \
    jq -r '.files[].url' | \
    xargs curl ${CURL_ARGS}
done

# EssentialsX
OLDIFS="${IFS}" # To reset later
IFS=$'\n' # Makes sure the loop distinguishes between each file ONLY with newlines
RESPONSE="$(curl -sX POST "https://api.modrinth.com/v2/version_file/e626f9f250470bcf2feffbc3740f738f9cee50ef/update" -H "Content-Type: application/json" --data-binary "${PAYLOAD}" | \
    jq -r '.files[].url')"
for ((ESSX_INT=0; ESSX_INT < "${#ESSENTIALSX[@]}"; ESSX_INT++))
do
  #shellcheck disable=SC2086 # We want word splitting on ${RESPONSE}.
  curl ${CURL_ARGS} "$(grep "${ESSENTIALSX["${ESSX_INT}"]}" <<< ${RESPONSE} )"
done
IFS="${OLDIFS}"

# Geyser and floodgate
for PROJECT in "${GEYSER[@]}"
do
  APIURL="https://download.geysermc.org/v2/projects/${PROJECT}/versions/latest/builds/latest"
  curl -#L -o "$(curl --silent -L "${APIURL}" |\
    jq -r .downloads.spigot.name)" "${APIURL}"/downloads/spigot
done

for JENKIN in "${!JENKINS[@]}"
do
  FILE="$(curl -s "https://${JENKIN}/lastSuccessfulBuild/api/json" | \
    jq -r '.artifacts[].relativePath' | grep "${JENKINS["${JENKIN}"]}")"
  curl ${CURL_ARGS} "https://${JENKIN}/lastSuccessfulBuild/artifact/${FILE}"
done

# Curseforge # TODO
for PROJECT in "${!CURSEFORGE[@]}"
do
  #shellcheck disable=SC2016 # It's not a var. It's an api key
  URL="$(curl --silent -H 'Accept: application/json' -H \
    'x-api-key: $2a$10$tPDlhGZIyk1w9xo7TEYP9uBLy083QUsL/7EwufoKHG/wZcvdfCn3e' \
    "https://api.curseforge.com/v1/mods/${PROJECT}/files?gameVersion=${CURSEFORGE["${PROJECT}"]}" | \
    jq -r '.data[].downloadUrl' | head -n 1 )"
  curl ${CURL_ARGS} "${URL/'edge.'/'mediafilez.'}"
done

#TODO: Hangar (Where are the api docs?)


