#!/bin/bash
# By Arthurmeade12. Last edited 2024/03/29
set -eu
WORLDS=('world' 'world_nether' 'terra' 'bskyblock_world')
TARGET_DIR="${TARGET_DIR:="$(dirname "${0}")"}"
BACKUP_THRESHOLD="${BACKUP_THRESHOLD:=9}"

print(){
  printf "\033[;1;34m%s\033[;0m\n" "${*}"
}

delete_old_backups(){
  local WORLD
  WORLD="$(find ../../backup/"${1}"/* | sort)"
  WORLD_BACKUPS="$(("$(wc -l <<< "${WORLD}" )"))"
  if [[ "${WORLD_BACKUPS}" -gt "${BACKUP_THRESHOLD}" ]]
  then
    #shellcheck disable=SC2046 # We want word splitting.
    rm $(head -n "$(("${WORLD_BACKUPS}" - "${BACKUP_THRESHOLD}"))" <<< "${WORLD}")
    # always remove oldest copy, aka always have ${BACKUP_THRESHOLD} copies
  fi
}

cd "${TARGET_DIR}"
print 'Starting backups of the following worlds: ' "${WORLDS[*]}"

#shellcheck disable=SC2048 # The variable is unqoted so we can loop.
for WORLD in ${WORLDS[*]}
do
  if [[ ! -d ./universe/"${WORLD}" ]]
  then
    printf "\033[;1;31m%s%s%s\033[;0m\n" 'ERROR: World ' "${WORLD}" ' does not exist. Skipping.'
    continue
  fi
  [[ ! -d backup/"${WORLD}" ]] && mkdir -p backup/"${WORLD}"
  cd universe/"${WORLD}"
  (tar -czpkf ../../backup/"${WORLD}"/"$(date +%Y-%m-%d_%H:%M)".tar.gz . && \
    # -p, preserve permissions, -k, do not overwrite an existing file (not more than 1 backup per minute), new one every hour with $TIME
    delete_old_backups "${WORLD}") &
  cd - 1>/dev/null
done

wait && print 'Backups complete.' # Concurrent backups are possible if we have multiple jobs which we wait on.
exit 0
