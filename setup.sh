#!/bin/bash
set -euxo pipefail
LOGFILE="$(dirname "$0")/setup.log"
# Log to file while still printing to console
exec > >(tee -a "$LOGFILE") 2>&1

# Avoid interactive prompts during package installation
export DEBIAN_FRONTEND=noninteractive

# Update and upgrade system packages
sudo apt-get update -y
sudo apt-get dist-upgrade -y || true

install_pkg() {
  local pkg="$1"
  echo "Installing $pkg via apt-get"
  if ! sudo apt-get install -y "$pkg"; then
    echo "Warning: failed apt install $pkg" >&2
    echo "Attempting pip install for $pkg"
    if ! sudo -H python3 -m pip install --no-cache-dir "$pkg"; then
      echo "Warning: pip install failed for $pkg" >&2
      echo "Attempting npm install for $pkg"
      if ! sudo npm install -g "$pkg"; then
        echo "Warning: npm install failed for $pkg" >&2
        echo "Attempting manual download for $pkg"
        if ! curl -L -o "/tmp/${pkg}.tar.gz" "https://example.com/${pkg}.tar.gz"; then
          echo "Warning: manual download failed for $pkg" >&2
        fi
      fi
    fi
  fi
}

# Core packages required for building and tooling
apt_packages=(
  shellcheck
)

for pkg in "${apt_packages[@]}"; do
  install_pkg "$pkg"
done

# Delegate to repository-specific script for additional dependencies
bash "$(dirname "$0")/.codex/setup.sh" "$@"
