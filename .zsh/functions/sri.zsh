# Generate SHA384 SRI hash for <filename>.
sri_hash () {
    if (( ARGC < 1 )); then
        printf 'usage: sri_hash <filename>\n'
        return 1;
    fi

    echo "sha384-$(openssl dgst -sha384 -binary "$1" | openssl base64 -A)"
}
