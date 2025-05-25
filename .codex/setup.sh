#!/bin/bash
set -euxo pipefail

# Update package lists
sudo apt-get update

# Install build and debug tools
sudo apt-get install -y \
  clang lld lldb clang-tools clangd \
  build-essential cmake make ninja-build \
  autoconf automake libtool pkg-config \
  gdb valgrind afl++ bison ccache \
  clang-tidy clang-format cppcheck \
  llvm llvm-dev llvm-bolt bolt \
  libclang-dev libclang-cpp-dev libclang-common-dev \
  libc++-dev libc++abi-dev \
  capnproto capnproto-dev \
  git curl wget nodejs npm \
  python3 python3-pip python3-venv \
  lcov

# Upgrade pip and install Python tooling for testing and linting
sudo -H python3 -m pip install --upgrade pip
sudo -H python3 -m pip install --no-cache-dir \
  pytest pytest-cov flake8 black mypy

# Install Node.js tooling for linting if needed

sudo npm install -g eslint

# Export environment variables for build tools
export CC="ccache clang"
export CXX="ccache clang++"
export YACC=bison
export BISON_PKGDATADIR=$(bison --print-datadir)
ccache --max-size=1G

# Print versions for debugging purposes
clang --version
lld --version
ccache --version
python3 --version
npm --version

echo "Setup complete"
