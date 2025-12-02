# File Path - ~/.config/fish/config.fish

echo " "

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting
export UV_VENV_CLEAR=1
export TERM=xterm-256color ssh
export PATH="$HOME/go/bin:$PATH"

alias ls="eza --icons=auto"
alias icat="kitten icat"
alias ssh="kitty +kitten ssh"
alias gst="$HOME/.config/scripts/gitreset.sh"

starship init fish | source
zoxide init --cmd cd fish | source
atuin init fish | source