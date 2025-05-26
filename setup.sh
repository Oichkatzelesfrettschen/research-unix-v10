#!/bin/bash
# Repository-specific setup script with logging and troubleshooting
set -euxo pipefail
LOGFILE="$(dirname "$0")/setup.log"
ERROR_LOG="$(dirname "$0")/setup.errors.log"
# Log to file while still printing to console
exec > >(tee -a "$LOGFILE") 2>&1
# Clear previous error log
: > "$ERROR_LOG"

log_error() {
  echo "ERROR: $1" | tee -a "$ERROR_LOG" >&2
}

# Avoid interactive prompts during package installation
export DEBIAN_FRONTEND=noninteractive

# Update and upgrade system packages
sudo apt-get update -y
sudo apt-get dist-upgrade -y || true

install_pkg() {
  local pkg="$1"
  echo "Installing $pkg via apt-get"
  if ! sudo apt-get install -y "$pkg"; then
    log_error "failed apt install $pkg"
    echo "Attempting pip install for $pkg"
    if ! sudo -H python3 -m pip install --no-cache-dir "$pkg"; then
      log_error "pip install failed for $pkg"
      echo "Attempting npm install for $pkg"
      if ! sudo npm install -g "$pkg"; then
        log_error "npm install failed for $pkg"
        echo "Attempting manual download for $pkg"
        if ! curl -L -o "/tmp/${pkg}.tar.gz" "https://example.com/${pkg}.tar.gz"; then
          log_error "manual download failed for $pkg"
        fi
      fi
    fi
  fi
}

resolve_issues() {
  if [ -s "$ERROR_LOG" ]; then
    echo "\nIssues were encountered during setup:" | tee -a "$LOGFILE"
    cat "$ERROR_LOG" | tee -a "$LOGFILE"
    echo "Review the errors above and address them before re-running the script." | tee -a "$LOGFILE"
  else
    echo "No issues detected during setup." | tee -a "$LOGFILE"
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

resolve_issues

echo "Setup script finished. Refer to $LOGFILE for full logs. If $ERROR_LOG exists, address listed issues and re-run." | tee -a "$LOGFILE"
