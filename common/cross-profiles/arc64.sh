# Cross build profile for ARC64.

XBPS_TARGET_MACHINE="arc64"
XBPS_TARGET_QEMU_MACHINE="arc64"
XBPS_CROSS_TRIPLET="arc64-linux-gnu"
XBPS_CROSS_CFLAGS="-mcpu=hs6x"
XBPS_CROSS_CXXFLAGS="$XBPS_CROSS_CFLAGS"
XBPS_CROSS_FFLAGS="$XBPS_CROSS_CFLAGS"
XBPS_CROSS_RUSTFLAGS="--sysroot=${XBPS_CROSS_BASE}/usr"
XBPS_CROSS_RUST_TARGET="arc64-unknown-linux-gnu"
