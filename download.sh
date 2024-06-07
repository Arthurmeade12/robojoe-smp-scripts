#!/usr/bin/env bash
set -u
TARGET_DIR="${TARGET_DIR:="$(dirname "${0}")"}"
CURL_ARGS='-JlOf#' # This variable is unquoted when expanded; word splitting will occur

SPIGOT=(
  'GravestonesPlus'
  'GrimAC' # Has Hangar too
  'HarderDespawn' # Hangar ONLY
  #'Protocollib Stable'
  #'MyWorlds Stable'
  'Vault' # Has Curseforge too
)
GEYSER=(
  # Geyser project names
  'geyser'
  'floodgate'
)
declare -A JENKINS=( # ['Jenkins base urls']='filename string to grep'
  ['ci.dmulloy2.net/job/ProtocolLib']='' # Protocollib Dev
  ['ci.lucko.me/job/LuckPerms']='bukkit/' # Luckperms
  ['ci.ender.zone/job/EssentialsX']='jars/EssentialsX-' # EssentialsX Dev
  ['ci.mg-dev.eu/job/BKCommonLib']='' # BKCommonLib Dev
)
MODRINTH=(
  # '9857f67f2fd1640bc4913a7e1781dfa8e167035c' # BKCommonLib Stable
  '29b2bf30efaab24aac0c3f147fbe9d13fb63436d' # Chunky
  '33b6c2b5dad6f5b99235d4883d4ac1a3d200c3d4' # ChunkyBorder
  'd7eec4b81240739ad6aec537ac42c772647b56de' # CoreProtect
  '7d59c830c5ea7683e0619f0524318e8ec1ef59c7' # Craftbook
  'f55005317a18ec583a64821cf310b91d8f475c15' # DiscordSRV
  'd2cd2591ea5af93a17f41d25068a6fb3247ac4c6' # DriveBackupV2
  '02bf45c4d531b6c644515091ef0d5e4b751f2852' # GriefPreventions
  #'bf503af2778cafe8621d5e3ba67ded95ca034058' # Maintenance # Author kennytv has not put the latest version on modrinth
  'fea27f4ca32dd777ba82992d2c0cdfb8598f07b7' # Mclo.gs
  #'83823933559b4bb8b2fde670f12220432b96d04a' # Terra # Has not updated to 1.20.6 and is heavily version dependent
  '2b308cbae2ffaa50be612b51d80bd91a7341b65c' # ViaBackwards
  '13ae61a3a4beb3e7d00f6f7763136f336f58ff6d' # ViaVersion
)

PAYLOAD='{
  "loaders": [
    "paper",
    "purpur"
  ],
  "game_versions": [
    "1.20.1",
    "1.20.4",
    "1.20.6"
  ]
}
'
# 1.20.1 is max version of EssentialsX (stable), Maintenance, and mclo.gs
# Paper needed by more plugins than not (even though we run purpur)

if ! cd "${TARGET_DIR}"
then
  printf "\033[;1;31m%s%s%s\033[;0m" 'The target directory ' "${TARGET_DIR}" ' does not exist Aborting '
  exit 1
fi

# Purpur
curl ${CURL_ARGS} 'https://api.purpurmc.org/v2/purpur/1.20.6/latest/download'

# Modrinth
for PROJECT in "${MODRINTH[@]}"
do
  curl -sX POST "https://api.modrinth.com/v2/version_file/${PROJECT}/update" -H "Content-Type: application/json" --data-binary "${PAYLOAD}" | \
    jq -r '.files[].url' | \
    xargs curl ${CURL_ARGS}
done


# Geyser and floodgate
for PROJECT in "${GEYSER[@]}"
do
  APIURL="https://download.geysermc.org/v2/projects/${PROJECT}/versions/latest/builds/latest"
  curl -#L -o "$(curl --silent -L "${APIURL}" |\
    jq -r .downloads.spigot.name)" "${APIURL}"/downloads/spigot
done

# Jenkins
for JENKIN in "${!JENKINS[@]}"
do
  FILE="$(curl -s "https://${JENKIN}/lastSuccessfulBuild/api/json" | \
    jq -r '.artifacts[].relativePath' | grep "${JENKINS["${JENKIN}"]}")"
  curl ${CURL_ARGS} "https://${JENKIN}/lastSuccessfulBuild/artifact/${FILE}"
done

echo "Plugins to update manually: ${SPIGOT[*]}"

#TODO: Hangar (Where are the api docs?)


