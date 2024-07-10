# Pfetch
echo ""
export PF_INFO="ascii title os wm editor shell kernel uptime palette"
pfetch



# Disable Fish Welcome Msg
set -g fish_greeting
starship init fish | source

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source


# Aliases

alias clean="sudo pacman -Scc  && paru -Scc "
alias icat="wezterm imgcat"
alias kcat="kitten icat"

alias arch='uu-arch'
alias b2sum='uu-b2sum'
alias b3sum='uu-b3sum'
alias base32='uu-base32'
alias base64='uu-base64'
alias basename='uu-basename'
alias basenc='uu-basenc'
alias cat='uu-cat'
alias chcon='uu-chcon'
alias chgrp='uu-chgrp'
alias chmod='uu-chmod'
alias chown='uu-chown'
alias chroot='uu-chroot'
alias cksum='uu-cksum'
alias comm='uu-comm'
alias cp='uu-cp'
alias csplit='uu-csplit'
alias coreutils='uu-coreutils'
alias cut='uu-cut'
alias date='uu-date'
alias dd='uu-dd'
alias df='uu-df'
alias dir='uu-dir'
alias dircolors='uu-dircolors'
alias dirname='uu-dirname'
alias du='uu-du'
alias env='uu-env'
alias expand='uu-expand'
alias expr='uu-expr'
alias factor='uu-factor'
alias false='uu-false'
alias fmt='uu-fmt'
alias fold='uu-fold'
alias groups='uu-groups'
alias hashsum='uu-hashsum'
alias head='uu-head'
alias hostid='uu-hostid'
alias hostname='uu-hostname'
alias id='uu-id'
alias install='uu-install'
alias join='uu-join'
alias kill='uu-kill'
alias link='uu-link'
alias ln='uu-ln'
alias logname='uu-logname'
alias ls='uu-ls'
alias md5sum='uu-md5sum'
alias mkdir='uu-mkdir'
alias mkfifo='uu-mkfifo'
alias mknod='uu-mknod'
alias mktemp='uu-mktemp'
alias more='uu-more'
alias mv='uu-mv'
alias nice='uu-nice'
alias nl='uu-nl'
alias nohup='uu-nohup'
alias nproc='uu-nproc'
alias numfmt='uu-numfmt'
alias od='uu-od'
alias paste='uu-paste'
alias pathchk='uu-pathchk'
alias pinky='uu-pinky'
alias pr='uu-pr'
alias printenv='uu-printenv'
alias ptx='uu-ptx'
alias pwd='uu-pwd'
alias readlink='uu-readlink'
alias realpath='uu-realpath'
alias rm='uu-rm'
alias rmdir='uu-rmdir'
alias runcon='uu-runcon'
alias seq='uu-seq'
alias sha1sum='uu-sha1sum'
alias sha224sum='uu-sha224sum'
alias sha256sum='uu-sha256sum'
alias sha3-224sum='uu-sha3-224sum'
alias sha3-256sum='uu-sha3-256sum'
alias sha3-384sum='uu-sha3-384sum'
alias sha3-512sum='uu-sha3-512sum'
alias sha384sum='uu-sha384sum'
alias sha3sum='uu-sha3sum'
alias sha512sum='uu-sha512sum'
alias shake128sum='uu-shake128sum'
alias shake256sum='uu-shake256sum'
alias shred='uu-shred'
alias shuf='uu-shuf'
alias sleep='uu-sleep'
alias sort='uu-sort'
alias split='uu-split'
alias stat='uu-stat'
alias stdbuf='uu-stdbuf'
alias stty='uu-stty'
alias sum='uu-sum'
alias sync='uu-sync'
alias tac='uu-tac'
alias tail='uu-tail'
alias tee='uu-tee'
alias timeout='uu-timeout'
alias touch='uu-touch'
alias tr='uu-tr'
alias true='uu-true'
alias truncate='uu-truncate'
alias tsort='uu-tsort'
alias tty='uu-tty'
alias uname='uu-uname'
alias unexpand='uu-unexpand'
alias uniq='uu-uniq'
alias unlink='uu-unlink'
alias uptime='uu-uptime'
alias users='uu-users'
alias vdir='uu-vdir'
alias wc='uu-wc'
alias who='uu-who'
alias whoami='uu-whoami'
alias yes='uu-yes'



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



