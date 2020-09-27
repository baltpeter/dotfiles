# Show a diff of non-Git files using diff-so-fancy.

function fdiff () {
    if (( ARGC < 2 )); then
        printf 'usage: fdiff <file>...\n'
        return 1;
    fi

    diff -u $@ | diff-so-fancy
}
