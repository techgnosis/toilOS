#! /bin/sh

set -exuo pipefail

apk update

apk add \
perl \
musl-dev \
gcc \
make \
linux-headers \
efivar-dev \
pkgconf \
efivar-dev \
popt-dev \
gettext-dev \
libelf \
efivar \
efivar-static

# Verify library exists
if [ ! -f /usr/lib/libefivar.so ] && [ ! -f /usr/lib64/libefivar.so ]; then
    echo "ERROR: libefivar not found!"
    ls -la /usr/lib/libefivar* /usr/lib64/libefivar* 2>/dev/null || true
    exit 1
fi

# Set explicit linking
export EFIDIR=BOOT

# Use pkg-config if available, otherwise force manual linking
if pkg-config --exists efivar; then
    export CFLAGS="$(pkg-config --cflags efivar)"
    export LDFLAGS="$(pkg-config --libs efivar)"
    echo "Using pkg-config for efivar"
else
    export CFLAGS="-I/usr/include/efivar"
    export LDFLAGS="-L/usr/lib -L/usr/lib64"
    echo "Using manual efivar linking"
fi

# Static linking for efibootmgr-static
export CFLAGS="$CFLAGS -static"
export LDFLAGS="$LDFLAGS -static"

cd source

# Debug: show what will be linked
echo "CFLAGS: $CFLAGS"
echo "LDFLAGS: $LDFLAGS"

#make clean
#make deps install # Verbose to see linking commands
make efibootmgr-static