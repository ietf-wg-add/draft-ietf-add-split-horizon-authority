#!/bin/bash

set +e

readonly SALT="example salt bytes (should be random)"
declare -ir SALT_LENGTH=$(expr length "${SALT}")
readonly SALT_LENGTH_BYTE="$(printf "\x$(printf %x "${SALT_LENGTH}")")"
readonly NAME1="\x07payroll\0"
readonly NAME2="\x06secret\x07project\0"
readonly HASH_OUTPUT="$(echo "${SALT_LENGTH_BYTE}${SALT}${NAME1}${NAME2}" | shasum -a 384 -)"
readonly HASH_OUTPUT_ARRAY=($HASH_OUTPUT)
readonly HASH_HEX="${HASH_OUTPUT_ARRAY[0]}"
readonly HASH="$(echo "${HASH_HEX}" | tr [:lower:] [:upper:] | basenc --base16 -d -)"
readonly HASH_BASE64="$(echo "${HASH}" | basenc --base64url -)"

echo "${HASH_BASE64}"
