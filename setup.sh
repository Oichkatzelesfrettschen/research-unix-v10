#!/bin/bash
set -euxo pipefail
LOGFILE="$(dirname "$0")/setup.log"
# Log to file while still printing to console
exec > >(tee -a "$LOGFILE") 2>&1

# Update and upgrade system packages
sudo apt-get update -y
sudo apt-get dist-upgrade -y || true

# Delegate to repository-specific script
bash "$(dirname "$0")/.codex/setup.sh" "$@"
