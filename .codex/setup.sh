#!/bin/bash
set -euxo pipefail

# Update package lists
sudo apt-get update

# Install build and debug tools
sudo apt-get install -y \
  clang lld lldb clang-tools \
  build-essential cmake make ninja-build \
  autoconf automake libtool pkg-config \
  gdb valgrind afl++ \
  clang-tidy clang-format cppcheck \
  git curl wget nodejs npm \
  python3 python3-pip python3-venv \
  lcov

# Upgrade pip and install Python tooling for testing and linting
sudo -H python3 -m pip install --upgrade pip
sudo -H python3 -m pip install --no-cache-dir \
  pytest pytest-cov flake8 black mypy

# Install Node.js tooling for linting if needed
sudo npm install -g eslint

# Print versions for debugging purposes
clang --version
lld --version
python3 --version
npm --version

echo "Setup complete"
