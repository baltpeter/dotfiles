wine_create_prefix() {
    if (( ARGC < 1 )); then
        printf 'usage: wine_create_prefix <prefix_name> [<arch>]\n\narguments:\n  <arch>        The Wine architecture (32 or 64) [default: 64].\n'
        return 1;
    fi

    local PREFIX_NAME=$1
    local ARCH=$2

    if [ -z "$ARCH" ]; then
        ARCH=64
    fi

    case $ARCH in
        32|64) ;;
        *) echo 'Only 32 or 64 are allowed as <arch>.\n'; return 1; ;;
    esac

    local PREFIX="/home/benni/wine-prefixes/$PREFIX_NAME"
    cp -R "/home/benni/wine-prefixes/_template$ARCH" "$PREFIX";
    export WINEARCH="win$ARCH";
    export WINEPREFIX="$PREFIX";
    open "$PREFIX";
}
