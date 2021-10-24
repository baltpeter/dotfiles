function ebook2azw3 () {
    if (( ARGC != 1 )); then
        printf 'usage: ebook2azw3 <epub-file>\n'
        return 1;
    fi

    ebook-convert "$1" "${1%.*}.azw3" --output-profile kindle_pw --keep-ligatures
}
