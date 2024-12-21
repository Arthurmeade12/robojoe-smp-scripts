#!/usr/bin/env bash
set -u
WHEREAMI="$(dirname "${0}")"
TARGET_DIR="${TARGET_DIR:="${WHEREAMI}"}"
#shellcheck disable=SC2086 # Word splitting intended for CURL_ARGS
CURL_ARGS='-JlOf# --clobber'

msg(){
  printf '\033[;1;32m ==> \033[0;m\033[;1m%s : \033[:0m\n' "${*}"
}

# Fail on macOS bash (3.2) which doesn't support associative arrays
if [[ "${BASH_VERSINFO}" -le 3 ]]
then
  msg "\033[31;mPlease install a newer version of bash to run this script"
  exit 2
fi

declare -A UNAVAILABLE=(
  # Spigot
  ['GraveStonesPlus']='https://www.spigotmc.org/resources/gravestonesplus.95132/updates'
  ['mcxboxbroadcast']='https://github.com/MCXboxBroadcast/Broadcaster/releases'
  #['MyWorlds']='https://www.spigotmc.org/resources/myworlds.39594/updates'
  ['Vault']='https://dev.bukkit.org/projects/vault/files'
  ['VaultChatFormatter']='https://www.spigotmc.org/resources/vaultchatformatter.49016/'
)

declare -A JENKINS=( # ['Jenkins base urls']='filename string to grep'
  ['ci.mg-dev.eu/job/BKCommonLib']='' # BKCommonLib Dev
  ['ci.mg-dev.eu/job/MyWorlds']='' # MyWorlds Dev
  ['ci.lucko.me/job/LuckPerms']='bukkit/' # Luckperms
  ['ci.ender.zone/job/EssentialsX']='jars/EssentialsX-' # EssentialsX Dev
)
declare -A MODRINTH=(
  #['BKCommonLib (Stable)']='7c018de6db70bcb81cf0312b4e6a158d983c9422' # 10/20/24
  ['Chunky']='b9366f80cf0045cbb791ba7e11e00f608b98d012' # 10/20/24
  ['Chunky Border']='33b6c2b5dad6f5b99235d4883d4ac1a3d200c3d4' # 10/20/24
  ['CoreProtect']='0613b4537bfaed09ca3ef93883abbb9f10c390f1' # 10/20/24
  ['Craftbook']='9e2ddfdeb9640cd201054d7078ce8ca49a1feff5' # 10/20/24
  ['DiscordSRV']='7ecbc8662b2681a33ad68ffa0858a9bceba655c7' # 10/20/24
  ['DriveBackupV2']='270296e8c60de29c17bdf04fc3060df95d842aa7' # 10/20/24
  ['Geyser']='dff59953beedd93a5591f32db573db76dbbcf6ad' # 10/20/24
  ['GriefPrevention']='1b6bf6bc24cdaf21d1e40cc4cfac99f0701bc4dd' # 10/20/24
  ['Grim Anticheat']='c27189490370a002e54ab399ad998309432e3514' # 10/20/24
  ['Maintenance']='ba93789d9bbbc1dd8d58333ff6e6b7ac1f015b9f' # 10/20/24
  ['mclo.gs']='fea27f4ca32dd777ba82992d2c0cdfb8598f07b7' # 10/20/24
  ['Pl3xMap']='da39a3ee5e6b4b0d3255bfef95601890afd80709' # Not working?
  ['Simple Voice Chat']='3745b56d2a8c15d98db68a449969d3690cfdb308' # 10/20/24
  ['Simple Voice Chat Discord Bridge']='33560ae663380366ab2d353118d6d39e58ec56d3' # 10/20/24
  ['ViaBackwards']='95af4be3c13aad778834dd2ed5e7447ea8f78485' # 10/20/24
  ['ViaVersion']='6680f915fc242bfc1fc847f54cd1056c74ec1b2d' # 10/20/24
  ['Worldedit']='75ac9e214a3dd8ebd53b7cb1e6f27d9a4d0479f0' # 10/22/24
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
    "1.21.1",
    "1.21.2",
    "1.21.3",
    "1.21.4"
  ]
}
'
# 1.20 for mclo.gs
# 1.20.6 for CoreProtect
# 1.21 for Craftbook, Simple Voice Chat Discord Bridge
# Paper for Chunky, Chunky Border, Geyser, GriefPrevention (maybe? inconsistent), Grim Anticheat, Maintenance, ViaBackwards, ViaVersion, Worldedit

### Code:

# Main folder check
if ! cd "${TARGET_DIR}"
then
  printf "\033[;1;31m%s%s%s\033[;0m" 'The target directory ' "${TARGET_DIR}" ' does not exist. Aborting ...'
  exit 1
fi

# Purpur
msg 'Purpur'
#shellcheck disable=SC2086 # Word splitting intended for CURL_ARGS
curl ${CURL_ARGS} 'https://api.purpurmc.org/v2/purpur/1.21.4/latest/download'

# Plugin folder check
[[ ! -d "${TARGET_DIR}/plugins" ]] && mkdir -p "${WHEREAMI}/plugins"
#shellcheck disable=SC2164
pushd ./plugins

# Modrinth
for PROJECT in "${!MODRINTH[@]}"
do
  msg "${PROJECT}"
  #shellcheck disable=SC2086 # Word splitting intended for CURL_ARGS
  curl -sX POST "https://api.modrinth.com/v2/version_file/${MODRINTH["${PROJECT}"]}/update" -H "Content-Type: application/json" --data-binary "${PAYLOAD}" | \
    jq -r '.files[].url' | \
    xargs curl ${CURL_ARGS}
done

# Floodgate
APIURL="https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest"
msg 'Floodgate'
curl -#L -o 'floodgate-spigot.jar' "${APIURL}/downloads/spigot"

# Jenkins
for JENKIN in "${!JENKINS[@]}"
do
  msg "${JENKIN}"
  FILE="$(curl -s "https://${JENKIN}/lastSuccessfulBuild/api/json" | \
    jq -r '.artifacts[].relativePath' | grep "${JENKINS["${JENKIN}"]}")"
  #shellcheck disable=SC2086 # Word splitting intended for CURL_ARGS
  curl ${CURL_ARGS} "https://${JENKIN}/lastSuccessfulBuild/artifact/${FILE}"
done

#shellcheck disable=SC2164
popd

echo "Plugins to update manually: ${!UNAVAILABLE[*]}"
echo -n 'Automatically open their URLs ? (y/n) : '
read -n 1 ANSWER
if [[ "${ANSWER}" = 'y' ]] || [[ "${ANSWER}" = 'Y' ]]
then
  case "$(uname)" in
    'Darwin') OPEN='open' ;;
    *) OPEN='xdg-open' ;;
  esac
  for LINK in "${!UNAVAILABLE[@]}"
  do
    "${OPEN}" "${UNAVAILABLE["${LINK}"]}"
  done
fi
printf '\n%s\n' "Date of last run: $(cat "${WHEREAMI}/.timestamp")"
date > "${WHEREAMI}/.timestamp"

