# Adapted from: https://github.com/garybernhardt/selecta/blob/f8ac0d00ea96196eaffcd2e7e457d231a1bd0be5/EXAMPLES.md#zsh-insert-fuzzy-found-paths-directly-into-the-shell-command-line

# Run fzf in the current working directory, appending the selected path, if
# any, to the current command, followed by a space.
function insert-fzf-path-in-command-line() {
    local selected_path
    # Print a newline or we'll clobber the old prompt.
    echo
    # Find the path; abort if the user doesn't select anything.
    selected_path=$(find * -type f | fzf) || return
    # Append the selection to the current command buffer.
    eval 'LBUFFER="$LBUFFER$selected_path "'
    # Redraw the prompt since fzf has drawn several new lines of text.
    zle reset-prompt
}
# Create the zle widget
zle -N insert-fzf-path-in-command-line
# Bind the key to the newly created widget
bindkey "^T" "insert-fzf-path-in-command-line"
