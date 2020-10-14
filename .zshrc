# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTSIZE=50000
SAVEHIST=100000
HISTFILE=~/.zsh_history

setopt histignorealldups hist_ignore_space nobeep
# Options copied from grml (https://github.com/grml/grml-etc-core/blob/e01bb8fd4f1afa24ac37638aee2ba1e68959ae2b/etc/zsh/zshrc)
setopt append_history share_history extended_history extended_glob longlistjobs notify noglobdots

################################################################################
# <Zinit>
################################################################################

# --- Setup ---

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"


# Some taken from: http://zdharma.org/zinit/wiki/Example-Minimal-Setup/ and http://zdharma.org/zinit/wiki/GALLERY/

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# zdharma/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"
zinit ice wait"1" lucid
zinit load zdharma/history-search-multi-word


# Programs

# diff-so-fancy
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma/zsh-diff-so-fancy

# direnv, taken from: http://zdharma.org/zinit/wiki/Direnv-explanation/
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    pick"direnv" src="zhook.zsh" for \
        direnv/direnv

zinit wait pack atload=+"zicompinit; zicdreplay" for system-completions
zinit wait pack"default+keys" atload"source ~/.zsh/fzf-ctrl-s.zsh" for fzf
zinit pack for fzy


# Theme

zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Autosuggestions & fast-syntax-highlighting
zinit ice wait lucid atinit"zicompinit; zicdreplay"
zinit light zdharma/fast-syntax-highlighting
# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions
# zsh-users/zsh-completions
zinit wait lucid light-mode blockf atpull'zinit creinstall -q .' for \
      zinit light zsh-users/zsh-completions
      zinit light srijanshetty/zsh-pandoc-completion
################################################################################
# </Zinit>
################################################################################

[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
[[ ! -f ~/.zshrc.priv ]] || source ~/.zshrc.priv

for file in ~/.zsh/functions/*.zsh; do
    source "$file"
done
