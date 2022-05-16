if [[ -z $DISPLAY ]] || [[ $(tty) = /dev/tty2 ]];then
	startx
fi
[[ -n "$TMUX" ]] && PROMPT_COMMAND='echo -n -e "\e]2;${PWD/${HOME}/~}\e\\"'
set -o vi
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'Control-a: beginning-of-line'
bind -m vi-insert 'Control-e: end-of-line'
bind -m vi-insert 'Control-w: backward-kill-word'
export PATH=/usr/local/bin:$PATH
export EDITOR=nvim
export LANG=en_US.UTF-8
#export TERM=xterm-256color
export JAVA_HOME='/usr/lib/jvm/java-17-openjdk/'
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOME/bin
export FZF_DEFAULT_COMMAND='fd . / --type f --color=never --hidden --absolute-path'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
shopt -s autocd
alias ..='cd ..'
alias s='sudo'
alias vi='nvim'
alias gs="git status"
alias rm='trash-put'
alias duck='du -cks * | sort -n -r | head -n 20'
alias duak='du -ak | sort -n -r | head -n 20'
alias l='ls -A -S -CF --color=auto'
alias ll='ls -A -n -LSh --color=always'
alias ls='ls -A -n -ltr --color=always'
alias f='fzf'
alias fd='fd . $HOME --absolute-path --type d . --color=never --hidden | fzf'
alias c='cd `fd`'
alias v='nvim `f`'
alias ip='ip --color=auto'
PS1="\[\e[0;31m\]\u@\[\e[m\e[0;34m\]\h\[\e[m \e[0;32m\]\W \$ \[\e[m\]"
HISTCONTROL=ignoreboth:erasedups
