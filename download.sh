#!/usr/bin/env bash
set -u
WHEREAMI="$(dirname "${0}")"
TARGET_DIR="${TARGET_DIR:="${WHEREAMI}"}"
CURL_ARGS='-JlOf#' # This variable is unquoted when expanded; word splitting will occur

declare -A UNAVAILABLE=(
  # Spigot
  ['GraveStonesPlus']='https://www.spigotmc.org/resources/gravestonesplus.95132/updates'
  ['MyWorlds']='https://www.spigotmc.org/resources/myworlds.39594/updates'
  ['Vault']='https://dev.bukkit.org/projects/vault/files'
  ['mcxboxbroadcast']='https://github.com/MCXboxBroadcast/Broadcaster/releases'
  ['ProtocolLib']='https://www.spigotmc.org/resources/protocollib.1997/updates'
)

declare -A JENKINS=( # ['Jenkins base urls']='filename string to grep'
  ['ci.lucko.me/job/LuckPerms']='bukkit/' # Luckperms
  ['ci.ender.zone/job/EssentialsX']='jars/EssentialsX-' # EssentialsX Dev
)
declare -A MODRINTH=(
  ['BKCommonLib (Stable)']='7c018de6db70bcb81cf0312b4e6a158d983c9422'
  ['Chunky']='29b2bf30efaab24aac0c3f147fbe9d13fb63436d'
  ['Chunky Border']='33b6c2b5dad6f5b99235d4883d4ac1a3d200c3d4'
  ['CoreProtect']='d7eec4b81240739ad6aec537ac42c772647b56de'
  ['Craftboook']='7d59c830c5ea7683e0619f0524318e8ec1ef59c7' #
  ['DiscordSRV']='f55005317a18ec583a64821cf310b91d8f475c15' #
  ['DriveBackupV2']='d2cd2591ea5af93a17f41d25068a6fb3247ac4c6' #
  ['Geyser']='dff59953beedd93a5591f32db573db76dbbcf6ad' # 10/20/24
  ['GriefPrevention']='02bf45c4d531b6c644515091ef0d5e4b751f2852' #
  ['Grim Anticheat']='c27189490370a002e54ab399ad998309432e3514' #
  ['Maintenance']='bf503af2778cafe8621d5e3ba67ded95ca034058' #
  ['mclo.gs']='fea27f4ca32dd777ba82992d2c0cdfb8598f07b7' #
  ['Pl3xMap']='da39a3ee5e6b4b0d3255bfef95601890afd80709' #
  ['Simple Voice Chat']='3745b56d2a8c15d98db68a449969d3690cfdb308' # 10/20/24
  ['Simple Voice Chat Discord Bridge']='33560ae663380366ab2d353118d6d39e58ec56d3' # 10/20/24
  ['ViaBackwards']='2b308cbae2ffaa50be612b51d80bd91a7341b65c' #
  ['ViaVersion']='13ae61a3a4beb3e7d00f6f7763136f336f58ff6d' #
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
# Paper needed by more plugins than not (even though we run purpur)

### Code:

# Main folder check
if ! cd "${TARGET_DIR}"
then
  printf "\033[;1;31m%s%s%s\033[;0m" 'The target directory ' "${TARGET_DIR}" ' does not exist. Aborting ...'
  exit 1
fi

# Purpur
curl ${CURL_ARGS} 'https://api.purpurmc.org/v2/purpur/1.21.1/latest/download'

# Plugin folder check
[[ ! -d "${TARGET_DIR}/plugins" ]] && mkdir -p "${WHEREAMI}/plugins"
#shellcheck disable=SC2164
pushd ./plugins

# Modrinth
for PROJECT in "${MODRINTH[@]}"
do
  curl -sX POST "https://api.modrinth.com/v2/version_file/${PROJECT}/update" -H "Content-Type: application/json" --data-binary "${PAYLOAD}" | \
    jq -r '.files[].url' | \
    xargs curl ${CURL_ARGS}
done


# Floodgate
APIURL="https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest"
curl -#L -o "$(curl --silent -L "https://download.geysermc.org/v2/projects/${PROJECT}/versions/latest/builds/latest" |\
jq -r .downloads.spigot.name)" "${APIURL}"/downloads/spigot

# Jenkins
for JENKIN in "${!JENKINS[@]}"
do
  FILE="$(curl -s "https://${JENKIN}/lastSuccessfulBuild/api/json" | \
    jq -r '.artifacts[].relativePath' | grep "${JENKINS["${JENKIN}"]}")"
  curl ${CURL_ARGS} "https://${JENKIN}/lastSuccessfulBuild/artifact/${FILE}"
done

#shellcheck disable=SC2164
popd

echo "Plugins to update manually: ${!UNAVAILABLE[*]}"
echo -n "Automatically open their URLs ? (y/n) : "
read -n 1 ANSWER
if [[ "${ANSWER}" = 'y' ]] || [[ "${ANSWER}" = 'Y' ]]
then
  for LINK in "${!UNAVAILABLE[@]}"
  do
    xdg-open "${UNAVAILABLE["${LINK}"]}"
  done
fi
printf '%s\n' "Date of last run: $(cat "${WHEREAMI}/.timestamp")"
date > "${WHEREAMI}/.timestamp"
