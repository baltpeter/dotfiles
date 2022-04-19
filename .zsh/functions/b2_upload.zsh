b2_upload() {
    if (( ARGC < 2 )) || (( ARGC > 3 )); then
        printf 'usage: b2_upload <bucket_name> <local_file> [<b2_path_prefix>]\n\narguments:\n  <bucket_name>     The B2 bucket to upload the file to [required].\n  <local_file>      The path to the file to upload [required].\n  <b2_path_prefix>  The prefix (folder) for the target path in B2, the filename will be kept [default: ""].\n'
        return 1;
    fi

    local BUCKET_NAME=$1
    local LOCAL_FILE=$2
    local PATH_PREFIX=$3

    if [ -z "$PATH_PREFIX" ]; then
        PATH_PREFIX=""
    fi

    local B2_PATH="$PATH_PREFIX/$(basename "$LOCAL_FILE")"

    # Trim leading slash from B2_PATH, see: https://stackoverflow.com/a/51496854
    b2 upload-file "$BUCKET_NAME" "$LOCAL_FILE" "${B2_PATH#/}"
}
