# Taken from grml: https://github.com/grml/grml-etc-core/blob/a7fd7af7604faef58c3d7eaa65e1cdb56cb8266c/etc/zsh/zshrc

function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}
