export PATH=/usr/local/bin:$PATH
export EDITOR=nvim
export LANG=en_US.UTF-8
export TERM=xterm-256color
export FZF_DEFAULT_COMMAND='fd . / --type f --color=never --hidden --absolute-path'
export FZF_DEFAULT_OPTS='--multi --no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export HISTFILESIZE=-1                     # unlimited
export HISTSIZE=-1                         # unlimited
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_history
shopt -s autocd
alias ..='cd ..'
alias sp='sudo pacman'
alias g="git"
alias rm="trash-put"
alias duck='du -cks * | sort -n -r | head -n 20'
alias duak='du -ak | sort -n -r | head -n 20'
alias l='ls -A -S -CF --color=auto'
alias ls='ls -A -n -LSh --color=always'
alias fd="fd . / --absolute-path --type d --hidden | fzf --preview 'tree -CL 2 {}'"
alias c=cd_fzf
alias v=vim_fzf
alias ip='ip --color=auto'
shopt -s histappend                      # append to history, don't overwrite it
PS1='\[\e[0;31m\]\u\[\e[0;31m\]@\[\e[0;34m\]\H \[\e[0;32m\]\W \[\e[0m\]$ \[\e[0m\]'

cd_fzf (){
if [[ $@ != "" ]]; then
    cd $@
    exec bash
 else
    FOO="`fd`"
fi
if [[ "${FOO}" != "" ]]; then
    cd $FOO
 else
    exec bash
fi
}

vim_fzf (){
if [[ $@ != "" ]]; then
    nvim $@
    exec bash
 else
    FOO="`fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'`"
fi
if [[ "${FOO}" != "" ]]; then
    nvim $FOO
 else
    exec bash
fi
}
# CTRL-R - Paste the selected command from history into the command line
if [[ "$-" =~ "i" ]]; then  # Check if it is an interactive terminal
    bind -x '"\C-r": hist_fzf'
fi

hist_fzf (){
    history -r;
    output=$( history | fzf --tac | sed -r 's/\[[^]]*\]//g' | sed -r 's/ *[0-9]*\*? *//')
    READLINE_LINE=${output#*$'\t'}
    READLINE_POINT=0x7fffffff
}
if [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ]; then
	startx
fi
[[ -n "$TMUX" ]] && PROMPT_COMMAND='echo -n -e "\e]2;${PWD/${HOME}/~}\e\\"; history -a; history -r;'
