#!/bin/bash
set -euxo pipefail

# Update package lists
sudo apt-get update

# Install build, debug, fuzzing and analysis tools
sudo apt-get install -y \
  clang lld lldb clang-tools \
  build-essential cmake make ninja-build \
  autoconf automake libtool pkg-config \
  gdb valgrind afl++ \
  clang-tidy clang-format cppcheck shellcheck codespell \
  git curl wget nodejs npm \
  python3 python3-pip python3-venv \
  lcov \
  coq coq-theories coq-mathcomp-ssreflect \
  tlaplus || true

# Upgrade pip and install Python tooling for testing and linting
sudo -H python3 -m pip install --upgrade pip
sudo -H python3 -m pip install --no-cache-dir \
  pytest pytest-cov flake8 black mypy pylint \
  hypothesis coverage pre-commit

# Install Node.js tooling for linting if needed
sudo npm install -g eslint prettier typescript

# Print versions for debugging purposes
clang --version
lld --version
python3 --version
npm --version

# Recommended build flags for performance and diagnostics
export CC=clang
export CXX=clang++
export CFLAGS="-O3 -march=native -pipe -fuse-ld=lld"
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-fuse-ld=lld"

echo "Setup complete"
