#!/bin/sh
# ============================================================
# raylib test build script (tcc compiler) - Unix version
#
# Usage:
#   ./build.sh        # Build test program
#   ./build.sh run    # Build and run
#   ./build.sh clean  # Clean
#
# Depends: root directory has lib/libraylib.a and include/raylib.h
# ============================================================

set -e

ROOT_DIR=".."
INCLUDE_DIR="$ROOT_DIR/include"
LIB_DIR="$ROOT_DIR/lib"
TARGET="test_raylib"

# -- Platform-specific link flags --
UNAME_S="$(uname -s 2>/dev/null)"
case "$UNAME_S" in
    Linux)
        LDLIBS="-L$LIB_DIR -lraylib -lm -ldl -lpthread -lX11 -lXext -lXcursor -lXinerama -lXi -lXrandr -lGL"
        ;;
    Darwin)
        LDLIBS="-L$LIB_DIR -lraylib -lm -framework OpenGL -framework Cocoa -framework IOKit"
        ;;
    *)
        LDLIBS="-L$LIB_DIR -lraylib -lm -ldl -lpthread -lX11 -lXext -lXcursor -lXinerama -lXi -lXrandr -lGL"
        ;;
esac

ACTION="${1:-build}"

case "$ACTION" in
    clean)
        echo "Cleaning..."
        rm -f "$TARGET"
        echo "Done."
        ;;
    build)
        echo "CC  main.c"
        tcc main.c -o "$TARGET" -I"$INCLUDE_DIR" -w $LDLIBS
        echo "Built $TARGET"
        ;;
    run)
        "$0" build
        echo "Running $TARGET..."
        ./"$TARGET"
        ;;
    *)
        echo "Usage: $0 [build|run|clean]"
        exit 1
        ;;
esac
