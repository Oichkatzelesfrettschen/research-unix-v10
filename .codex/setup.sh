#!/bin/bash
set -euo pipefail

# Avoid interactive prompts during package installation
export DEBIAN_FRONTEND=noninteractive

# Update package lists
sudo apt-get update -y

# List of apt packages to install.  Each is installed
# individually so failures do not stop the script.
apt_packages=(
  clang lld lldb clang-tools clangd
  build-essential cmake make ninja-build
  autoconf automake libtool pkg-config
  gdb valgrind afl++ bison ccache
  clang-tidy clang-format cppcheck
  llvm llvm-dev llvm-bolt bolt
  libclang-dev libclang-cpp-dev libclang-common-dev
  libc++-dev libc++abi-dev
  capnproto capnproto-dev
  git curl wget nodejs npm
  python3 python3-pip python3-venv
  lcov
  agda agda-stdlib coq coqide isabelle tlaplus
)

for pkg in "${apt_packages[@]}"; do
  echo "Installing $pkg"
  if ! sudo apt-get install -y "$pkg"; then
    echo "Warning: failed to install $pkg" >&2
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
ccache --max-size=1G

# Print versions for debugging purposes
clang --version || true
lld --version || true
ccache --version || true
python3 --version || true
npm --version || true

echo "Setup complete"
