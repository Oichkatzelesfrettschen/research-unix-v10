#!/bin/bash
set -euo pipefail
LOGFILE="$(dirname "$0")/setup.log"
exec > >(tee -a "$LOGFILE") 2>&1

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y
sudo apt-get dist-upgrade -y || true

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
  agda agda-stdlib coq coqide \
  isabelle isabelle-doc isabelle-dev isabelle2023 tlaplus
  default-jdk default-jre openjdk-11-jdk openjdk-11-jre-headless
)

for pkg in "${apt_packages[@]}"; do
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
done

sudo apt-get clean

sudo -H python3 -m pip install --upgrade pip || true
pip_packages=(pytest pytest-cov flake8 black mypy pre-commit)
for pkg in "${pip_packages[@]}"; do
  echo "Pip installing $pkg"
  if ! sudo -H python3 -m pip install --no-cache-dir "$pkg"; then
    echo "Warning: failed to install $pkg" >&2
  fi
done

npm_packages=(eslint)
for pkg in "${npm_packages[@]}"; do
  echo "NPM installing $pkg"
  if ! sudo npm install -g "$pkg"; then
    echo "Warning: failed to install $pkg" >&2
  fi
done

git submodule update --init --recursive || true

if command -v pre-commit >/dev/null 2>&1; then
  pre-commit install || true
fi

export CC="ccache clang"
export CXX="ccache clang++"
export YACC=bison
export BISON_PKGDATADIR=$(bison --print-datadir)
export CFLAGS="-O3 -pipe -flto=thin -fuse-ld=lld -march=native -fno-omit-frame-pointer -g -mllvm -polly -mllvm -polly-vectorizer=polly"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=lld -Wl,-O2"
export TLA_HOME="/usr/share/tlaplus"
export TLA_TOOLS_JAR="$TLA_HOME/tla2tools.jar"
export PATH="$PATH:$TLA_HOME:$TLA_HOME/bin"
export ISABELLE_HOME="/usr/lib/isabelle"
export ISABELLE_HOME_USER="$HOME/.isabelle"
export PATH="$PATH:$ISABELLE_HOME/bin"
export COQBIN="$(dirname $(command -v coqc || echo /usr/bin))"
export COQLIB="$(coqtop -where 2>/dev/null || echo /usr/lib/coq)"
export PATH="$PATH:$COQBIN"
export AGDA_BIN="$(dirname $(command -v agda || echo /usr/bin))"
export AGDA_DIR="$(agda-mode locate 2>/dev/null || echo $HOME/.agda)"
export PATH="$PATH:$AGDA_BIN"
if command -v isabelle >/dev/null 2>&1; then
  isabelle components -I || true
  isabelle components -a || true
  isabelle build -b HOL || true
fi
ccache --max-size=1G

clang --version || true
lld --version || true
ccache --version || true
python3 --version || true
npm --version || true
agda --version || true
coqc --version || true
isabelle version || true
tlapm --help >/dev/null 2>&1 && tlapm --version || true

echo "Setup complete"
