#!/bin/bash

generate_ssh_key() {
  local email=$1
  ssh-keygen -t ed25519 -C "${email}"
  cat ~/.ssh/id_ed25519.pub
}

generate_gpg_key() {
  gpg --full-generate-key
  local secret_keys=$(gpg --list-secret-keys --keyid-format=long)
  echo "${secret_keys}"
  local gpg_key_id=$(echo "${secret_keys}" | awk '/sec/{print $2}' | awk -F'/' '{print $2}')
  gpg --armor --export "${gpg_key_id}"
}

main() {
  local email="benjaminshawki@gmail.com"
  generate_ssh_key "${email}"
  generate_gpg_key
}

main