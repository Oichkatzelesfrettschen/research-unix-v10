#!/bin/bash
set -euo pipefail
set -x

# Some Codex environments block outbound networking after initialization.
# This helper avoids hanging apt when the network is unavailable.
check_network() {
  if ping -c1 -W1 8.8.8.8 >/dev/null 2>&1; then
    return 0
  else
    echo "Warning: network unreachable; skipping apt operations" >&2
    return 1
  fi
}
exec > >(tee -a /var/log/research-unix-setup.log) 2>&1

# Avoid interactive prompts during package installation
export DEBIAN_FRONTEND=noninteractive

# Update package lists and upgrade if networking is available
if check_network; then
  sudo apt-get update -y
  sudo apt-get dist-upgrade -y || true
fi

# List of apt packages to install.  Each is installed
# individually so failures do not stop the script.
apt_packages=(
  clang lld lldb clang-tools clangd
  clang-17 lld-17 lldb-17 clang-tools-17 clang-tidy-17 clang-format-17 clangd-17
  build-essential cmake make ninja-build
  autoconf automake libtool pkg-config
  gdb valgrind afl++ bison ccache
  clang-tidy clang-format cppcheck
  llvm llvm-dev llvm-bolt bolt mold
  libclang-dev libclang-cpp-dev libclang-common-dev
  libc++-dev libc++abi-dev
  capnproto capnproto-dev
  z3 libz3-dev
  git curl wget nodejs npm
  python3 python3-pip python3-venv
  lcov
  agda agda-stdlib coq coqide isabelle tlaplus
)

for pkg in "${apt_packages[@]}"; do
  echo "Installing $pkg via apt-get"
  if check_network && ! sudo apt-get install -y "$pkg"; then
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
done

# Clean up apt cache to keep the image small
sudo apt-get clean

# Upgrade pip and install Python tooling for testing and linting
sudo -H python3 -m pip install --upgrade pip || true
pip_packages=(pytest pytest-cov flake8 black mypy pre-commit)
for pkg in "${pip_packages[@]}"; do
  echo "Pip installing $pkg"
  if ! sudo -H python3 -m pip install --no-cache-dir "$pkg"; then
    echo "Warning: failed to install $pkg" >&2
  fi
done

# Install Node.js tooling for linting if needed
npm_packages=(eslint)
for pkg in "${npm_packages[@]}"; do
  echo "NPM installing $pkg"
  if ! sudo npm install -g "$pkg"; then
    echo "Warning: failed to install $pkg" >&2
  fi
done

# Initialize git submodules
git submodule update --init --recursive || true

# Install pre-commit hooks if available
if command -v pre-commit >/dev/null 2>&1; then
  pre-commit install || true
fi

# Export environment variables for build tools
export CC="ccache clang"
export CXX="ccache clang++"
export YACC=bison
export BISON_PKGDATADIR=$(bison --print-datadir)
export CFLAGS="-O3 -pipe -flto=thin -fuse-ld=lld -march=native -fno-omit-frame-pointer -g -mllvm -polly -mllvm -polly-vectorizer=polly"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=lld -Wl,-O2"
ccache --max-size=1G

# Print versions for debugging purposes
clang --version || true
lld --version || true
ccache --version || true
python3 --version || true
npm --version || true

echo "Setup complete"
if [ -s /var/log/research-unix-setup.log ]; then
  echo "Review /var/log/research-unix-setup.log for any warnings." >&2
fi
