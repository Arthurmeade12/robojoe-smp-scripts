#!/usr/bin/env bash
set -u
WHEREAMI="$(dirname "${0}")"
TARGET_DIR="${TARGET_DIR:="${WHEREAMI}"}"
CURL_ARGS='-JlOf#' # This variable is unquoted when expanded; word splitting will occur

declare -A UNAVAILABLE=(
  # Spigot
  ['GraveStonesPlus']='https://www.spigotmc.org/resources/gravestonesplus.95132/updates'
  ['HarderDespawn']='https://hangar.papermc.io/Kyle/harderdespawn/versions' # Hangar ONLY
  ['MyWorlds']='https://www.spigotmc.org/resources/myworlds.39594/updates'
  ['Vault']='https://dev.bukkit.org/projects/vault/files'
  ['mcxboxbroadcast']='https://github.com/MCXboxBroadcast/Broadcaster/releases'
)
#SPIGET=(
#  '95132' # GraveStonesPlus
#  '39594' # MyWorlds Stable
#  '34315' # Vault
#  #'1997' # Protocollib Stable
#)

GEYSER=(
  # Geyser project names
  'geyser'
  'floodgate'
)
declare -A JENKINS=( # ['Jenkins base urls']='filename string to grep'
  ['ci.dmulloy2.net/job/ProtocolLib']='' # Protocollib Dev
  ['ci.lucko.me/job/LuckPerms']='bukkit/' # Luckperms
  ['ci.ender.zone/job/EssentialsX']='jars/EssentialsX-' # EssentialsX Dev
  #['ci.mg-dev.eu/job/BKCommonLib']='' # BKCommonLib Dev
  #['ci.mg-dev.eu/job/MyWorlds']='' # MyWorlds Dev
)
MODRINTH=(
  '7c018de6db70bcb81cf0312b4e6a158d983c9422' # BKCommonLib Stable
  '29b2bf30efaab24aac0c3f147fbe9d13fb63436d' # Chunky
  '33b6c2b5dad6f5b99235d4883d4ac1a3d200c3d4' # ChunkyBorder
  'd7eec4b81240739ad6aec537ac42c772647b56de' # CoreProtect
  '7d59c830c5ea7683e0619f0524318e8ec1ef59c7' # Craftbook
  'f55005317a18ec583a64821cf310b91d8f475c15' # DiscordSRV
  'd2cd2591ea5af93a17f41d25068a6fb3247ac4c6' # DriveBackupV2
  '02bf45c4d531b6c644515091ef0d5e4b751f2852' # GriefPrevention
  'c27189490370a002e54ab399ad998309432e3514' # GrimAC
  'bf503af2778cafe8621d5e3ba67ded95ca034058' # Maintenance # Author kennytv has not put the latest version on modrinth
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
    "1.20",
    "1.20.6",
    "1.21",
    "1.21.1"
  ]
}
'
# 1.20 for mclo.gs
# 1.20.1 is max version of EssentialsX (stable)
# Paper needed by more plugins than not (even though we run purpur)

if ! cd "${TARGET_DIR}"
then
  printf "\033[;1;31m%s%s%s\033[;0m" 'The target directory ' "${TARGET_DIR}" ' does not exist Aborting '
  exit 1
fi
[[ ! -d "${TARGET_DIR}/plugins" ]] && mkdir -p "${WHEREAMI}/plugins"

# Purpur
curl ${CURL_ARGS} 'https://api.purpurmc.org/v2/purpur/1.21.1/latest/download'

pushd ./plugins

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

popd

echo "Plugins to update manually: ${!UNAVAILABLE[*]}"
echo -n "Automatically open their URLs ? (y/n) : "
read -n 1 ANSWER
if [[ "${ANSWER}" = 'y' ]] || [[ "${ANSWER}" = 'Y' ]]
then
  for X in "${!UNAVAILABLE[@]}"
  do
    xdg-open "${UNAVAILABLE["${X}"]}"
  done
fi
printf '%s\n' "Date of last run: $(cat "${WHEREAMI}/.timestamp")"
date > "${WHEREAMI}/.timestamp"



