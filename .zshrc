autoload -U compinit && compinit
zmodload -i zsh/complist

# history
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt INC_APPEND_HISTORY # history gets shared between sessions immediately
setopt SHARE_HISTORY # share history between all sessions
setopt EXTENDED_HISTORY # timestamps in history
setopt APPEND_HISTORY # sessions append the history list to the history file rather than replace it

# input and command completion
setopt CORRECT # command spelling correction
setopt MENUCOMPLETE # on ambiguous completion insert the first match, if tab, remove and insert next

setopt prompt_subst
# prepare some tmux sweetness
settitle() {
    title="$(whoami)"
    if [ $# -eq 1 ]; then
        title=$1
    fi
	echo -ne "\033]2;$title\033\\" # this is pane name
    #echo -ne "\033k$title\033\\" # this is window title / command 
}

tmuxprompt() {
    if [ "$(whoami)" = "root" ]; then
        tmux set -g status-left-bg red
        tmux set -g status-left "[!!!] ROOT "
    else
        tmux source-file .tmux.conf
    fi
}

function precmd() {
    env | grep -q "TMUX_PANE"
    if [[ $? -eq 0 ]]; then # a match is $? == 0
    #    tmuxprompt
        settitle
    fi 
}

# env vars 
export EDITOR=vim
export LC_MESSAGES="en_US.utf8"
export PROMPT="$(print '[%!] %{\e[0;37m%}%n%{\e[0m%}@%{\e[0;38;5;26m%}%m%{\e[0m%}: %{\e[0;32m%}%~%{\e[0m%}') %B%#%b "


# Aliases
alias ll="ls -lFh"
alias ls="ls --color"
alias hist='history -i -t "%F %T" 0'
alias gp++="g++ -ansi -O2 -DNDEBUG -Wall -Wextra -Werror -Wno-uninitialized -Wno-sign-compare -Wshadow"
alias my-puppet="sudo puppet agent --test --environment $USER"

# Python dev
alias vactivate="source .venv/bin/activate"

# Suffix alias
if [[ "$OSTYPE" == darwin* ]]; then
    alias imgview=open
    alias pdfview=open
else
    alias imgview=feh --scale
    alias pdfview=xpdf
fi
# source code 
#alias -s py=$EDITOR
#alias -s go=$EDITOR
alias -s c=$EDITOR
alias -s cpp=$EDITOR
alias -s pl=$EDITOR
alias -s js=$EDITOR
alias -s css=$EDITOR
alias -s html=$EDITOR
alias -s htm=$EDITOR
# text 
alias -s txt=$EDITOR
alias -s md=$EDITOR

# images
alias -s jpg=imgview
alias -s jpeg=imgview
alias -s gif=imgview
alias -s png=imgview

# other files
alias -s pdf=pdfview

#eval `ssh-agent`
#/usr/bin/keychain -Q -q ~/.ssh/id_rsa
#[[ -f $HOME/.keychain/$HOSTNAME-sh ]] && source $HOME/.keychain/$HOSTNAME-sh

bindkey -e # use emacs keybindings for shell
bindkey "^R" history-incremental-pattern-search-backward

ssh() {
    # make sure we are inside TMUX
    env | grep -q "TMUX_PANE"
    if [[ $? -eq 0 ]]; then # a match is $? == 0
		PANE_NAME="ssh/$(echo $* | cut -d ' ' -f 1 )"
		settitle $PANE_NAME
        command ssh "$@"
    else
        command ssh "$@"
    fi
}

