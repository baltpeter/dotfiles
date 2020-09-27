wine_create_prefix() {
    PREFIX="/home/benni/wine-prefixes/$1"
    cp -R '/home/benni/wine-prefixes/_template64' "$PREFIX";
    export WINEARCH=win64;
    export WINEPREFIX=$PREFIX;
    open $PREFIX;
}
