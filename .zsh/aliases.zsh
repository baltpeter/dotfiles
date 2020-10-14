# temporary Firefox profile, see https://news.ycombinator.com/item?id=18898865
alias fx="firefox --new-instance --profile $(mktemp -d)"

alias add="git add . && git commit -m"

alias open=xdg-open


# Replace various default utilities with better alternatives. Also set some nice default options.
# Note that due to the way my dotfiles repo is setup, pretty much my entire home directory is gitignored. Thus, we need
# to ignore gitignores by default…
alias fd="fd --hidden --no-ignore"
alias ls="exa"
alias ll="ls -l"
alias cat="bat"
