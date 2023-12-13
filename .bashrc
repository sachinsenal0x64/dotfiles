#! /bin/bash

# ~/.bashrc

# Gnupg

export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Default Apps

export EDITOR="lvim"

export XDG_DATA_HOME="$HOME/.local/share"

export XDG_CONFIG_HOME="$HOME/.config"

export XDG_STATE_HOME="$HOME/.local/state"

export XDG_CACHE_HOME="$HOME/.cache"



# Python

export PYTHONSTARTUP="/etc/python/pythonrc"


# Startship Launch
eval "$(starship init bash)"


# Pfetch

echo ""
export PF_INFO="ascii title os wm editor kernel pkgs uptime palette"
pfetch


# Alias

alias clean="sudo pacman -Scc  && paru -Scc "
alias icat="kitten icat"
alias vim='nvim'
alias ls='eza -al --icons'
alias vi='lvim'
alias rec='~/dotfiles/scripts/screen_record.sh'
alias gyr="gyr --replace"
alias sudo='sudo -E'
alias sync='rsync -avzh --progress --stats'
alias activate='~/Documents/hifi_tui/bin/activate'
alias dotbak='sync ~/dotfiles/ ~/Documents/github/dotfiles/'
alias pdir='cd ~/Documents/github/'
[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'



# Yazi 

function ya() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Yarn 



## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

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

export HISTFILE="$XDG_STATE_HOME"/bash/.bash_history

# Rust


export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export CARGO_HOME="$XDG_DATA_HOME"/.cargo
