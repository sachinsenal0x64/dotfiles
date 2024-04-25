#! /bin/bash

# CD Alternative tool

eval "$(zoxide init bash)"
export TERM=xterm-256color



# Flyctl 

export FLY_CONFIG_DIR="$XDG_STATE_HOME"/fly
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Pyenv

export PYENV_ROOT="$XDG_DATA_HOME"/pyenv 
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# Cargo Path 

export CARGO_HOME="/home/pc/.local/share/.cargo/bin"
case ":$PATH:" in
  *":$CARGO_HOME:"*) ;;
  *) export PATH="$CARGO_HOME:$PATH" ;;
esac


# local Path

export LOCAL_BIN_HOME="/home/pc/.local/bin/"
case ":$PATH:" in
  *":$LOCAL_BIN_HOME:"*) ;;
  *) export PATH="$LOCAL_BIN_HOME:$PATH" ;;
esac


# GTK 2

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Icons

export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

# Redis

export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/rediscli_history


# Mitm Proxy

alias mitmproxy="mitmproxy --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias mitmweb="mitmweb --set confdir=$XDG_CONFIG_HOME/mitmproxy"

# Clipboard as cb

export CLIPBOARD_NOAUDIO=1


# Gnupg

export GNUPGHOME="$XDG_DATA_HOME"/gnupg


# Default Apps

export EDITOR="nvim"

export XDG_DATA_HOME="$HOME/.local/share"

export XDG_CONFIG_HOME="$HOME/.config"

export XDG_STATE_HOME="$HOME/.local/state"

export XDG_CACHE_HOME="$HOME/.cache"



# Locale

export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Functions

fzz() {

  EXTERNAL_COLUMNS=$COLUMNS \
  fzf --preview='2>/dev/null kitten icat --clear --transfer-mode=memory --place="$COLUMNS"x"$LINES"@"$(($EXTERNAL_COLUMNS-$COLUMNS))"x10 --align center --stdin=no {} >/dev/tty && bat --color always --style numbers --theme TwoDark --line-range :200 {}'

}



# Python

export PYTHONSTARTUP="/etc/python/pythonrc"


# Eval Launch

eval "$(starship init bash)"
starship preset nerd-font-symbols -o ~/dotfiles/starship/starship.toml


eval "$(thefuck --alias)"


# Pfetch

echo ""
export PF_INFO="ascii title os wm editor shell kernel uptime palette"
pfetch


# Alias

alias clean="sudo pacman -Scc  && paru -Scc "
alias icat="kitten icat"
alias ls='eza -al --icons'
alias tree='eza -T'
alias vi='nvim'
alias irec='~/dotfiles/scripts/intel_screen.sh'
alias rec='~/dotfiles/scripts/screen_record.sh'
alias gyr="gyr --replace"
alias ssh="kitten ssh"
alias sudo='sudo -E'
alias sync='rsync -avzh --progress --stats'
alias activate='source ~/Documents/venv/pyenv/bin/activate'
alias dotbak='sync ~/dotfiles/ ~/Documents/github/dotfiles/ && sync ~/.bashrc ~/Documents/github/dotfiles/'
alias pdir='cd ~/Documents/github/'
alias cat="bat --color always --style numbers --theme TwoDark"
alias dl="n-m3u8dl-re"
alias mitm="~/dotfiles/scripts/mitmproxy.sh"
alias mitmc="~/dotfiles/scripts/mitmclear.sh"
alias fly="flyctl"
alias noi="ali"


#Image Optimization
alias optimize='~/.img-optimize/optimize.sh'
alias cert='~/Downloads/cacert.pem'
alias jrpc='aria2c --enable-rpc --dir=/home/pc/Documents/tv/ --daemon'
alias music='musikcube'
alias bashrc='source ~/.bashrc && clear'

# SMS RECEIVE FROM MOBILE VIA ADB


alias sms='~/dotfiles/scripts/sms.sh'

# Power Menu

alias restart='systemctl reboot'
alias shutdown='systemctl poweroff'
alias sleep='systemctl suspend'
alias hibernate='systemctl hibernate'
alias lock='slock'
alias logout="~/dotfiles/scripts/logout.sh"

# Whoami

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'



# Yazi 

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Reverse History Search 

fzf_history_search() {
  local selected_command
  selected_command=$(fc -ln 1 | fzf --color=16 )  # Get command using fzf
  READLINE_LINE="$selected_command"  # Set selected command to READLINE_LINE
  READLINE_POINT=${#READLINE_LINE}   # Move cursor to the end of the line
}


# Key Binds

bind -x '"\C-r": fzf_history_search'  # Reverse Search  Bind Ctrl+R to the function

bind -x '"\C-f": fzz'  # fzf + image preview





_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}


#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

# GIT

export XDG_CONFIG_HOME="$HOME/.config"

export GIT_HOME="$XDG_CONFIG_HOME/git"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/.gitconfig"


git config --global credential.helper "store --file=$GIT_HOME/.git-credentials"


# Bash


export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

export HISTFILE="${XDG_STATE_HOME}"/bash/history

export HISTSIZE=10000

export HISTFILESIZE=2000000


# Rust

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export CARGO_HOME="$XDG_DATA_HOME"/.cargo


# GO

export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH="$XDG_DATA_HOME"/go

# bun

export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH



# Java

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
