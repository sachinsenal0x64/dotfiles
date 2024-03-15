if [ -f $HOME/dotfiles/bashrc/.bashrc ]; then
        source $HOME/.bashrc
fi

export PATH
export PS1="$PS1[\e]1337;CurrentDir="'$(pwd)\a]'


