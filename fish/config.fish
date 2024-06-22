# Pfetch
echo ""
export PF_INFO="ascii title os wm editor shell kernel uptime palette"
pfetch


# Disable Fish Welcome Msg
set -g fish_greeting

starship init fish | source

# Aliases
alias clean="sudo pacman -Scc  && paru -Scc "
alias icat="kitten icat"
alias ls='eza -al --icons'
alias task='go-task'
alias tree='eza -T'
alias vi='nvim'
alias irec='~/dotfiles/scripts/intel_screen.sh'
alias rec='~/dotfiles/scripts/screen_record.sh'
alias gyr="gyr --replace"
alias hot="browser-sync --no-notify start --server --files './**/'"
alias sudo='sudo -E'
alias sync='rsync -avzh --progress --stats'
alias activate='source ~/Documents/venv/pyenv/bin/activate.fish'
alias dotbak='~/dotfiles/backup.sh'
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
alias hiber='systemctl hibernate'
alias lock='slock'
alias logout="~/dotfiles/scripts/logout.sh"

# MitmProxy
alias mitmproxy="mitmproxy --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias mitmweb="mitmweb --set confdir=$XDG_CONFIG_HOME/mitmproxy"



# Yazi
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end



# GIT
export XDG_CONFIG_HOME="$HOME/.config"
export GIT_HOME="$XDG_CONFIG_HOME/git"
export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/.gitconfig"
git config --global credential.helper "store --file=$GIT_HOME/.git-credentials"


# Clipboard as cb
export CLIPBOARD_NOAUDIO=1


# Default Apps
export EDITOR="nvim"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"



# Python
export PYTHONSTARTUP="/etc/python/pythonrc"

# Gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Zoxide is a smarter cd command
zoxide init --cmd cd fish | source


# GTK 2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Icons
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

# Redis
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/rediscli_history


# Cargo path
set -gx CARGO_HOME "$HOME/.local/share/.cargo/bin"
set -gx PATH $CARGO_HOME $PATH


# local Path
set -gx LOCAL_BIN_HOME "$HOME/.local/bin/"
set -gx PATH $LOCAL_BIN_HOME $PATH


# Rust
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/.cargo"

# GO
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GOBIN "$XDG_DATA_HOME/go/bin"
set -gx PATH $GOPATH/bin $PATH
set -gx PATH $GOBIN/bin $PATH


# bun
set -gx BUN_INSTALL "$XDG_DATA_HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH


# Flyctl 
set -gx FLY_CONFIG_DIR "$XDG_STATE_HOME"/fly
set -gx PATH "$FLYCTL_INSTALL/bin:$PATH"


# Pyenv
set -gx PYENV_ROOT "$XDG_DATA_HOME"/pyenv 
if test -d $PYENV_ROOT/bin 
   set -gx PATH "$PYENV_ROOT/bin:$PATH"
end
pyenv init - | source


# Term 
export TERM=xterm-256color

# Locale
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Prompt
export STARSHIP_CACHE="$HOME/.cache/starship/cache"


export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java


# Android
export ANDROID_HOME="$XDG_DATA_HOME"/android/sdk


# MPEG-4 Part 2

export VAAPI_MPEG4_ENABLED=true
