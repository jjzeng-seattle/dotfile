# $Id: //depot/google3/googledata/corp/puppet/goobuntu/common/modules/shell/files/bash/skel.bashrc#4 $
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

export shorthostname=$(hostname -s)
smiley() {
  if [ $? = 0 ]; then
    printf $1
  else
    printf $2
  fi
  return $?
}

export PROMPT_DIRTRIM=4
#PS1='${smiley debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#export PS1='\n${shorthostname}$(smiley "\[\033[01;32m\]:)\[\033[00m\]" "\[\033[01;31m\]:(\[\033[00m\]")\[\033[0;35m\]$PWD\[\033[0;33m\][$(kubectl config view -o jsonpath='{.current-context}' | cut -d'_' -f4)]>>\n$'
export PS1='\n${shorthostname}$(smiley "\[\033[01;32m\]:)\[\033[00m\]" "\[\033[01;31m\]:(\[\033[00m\]")\[\033[0;35m\]\w\[\033[0;33m\][$(kubectl config view -o jsonpath='{.current-context}' | cut -d'_' -f4)]>>\n$'
#export PS1='\n${shorthostname}$(smiley "\[\033[01;32m\]:)\[\033[00m\]" "\[\033[01;31m\]:(\[\033[00m\]")\[\033[0;35m\]$(sodiumSierraStrawberry ${PWD})\[\033[0;33m\][$(kubectl config view -o jsonpath='{.current-context}' | cut -d'_' -f4)]>>\n$'
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..="cd .."
alias ...="cd ../.."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias rm='rm -i'

alias last20='history | tail -20'
alias gh='history | grep '
# alias gp='ps aux | grep '


export DISPLAY=:1.0
export PATH=$PATH:~/.local/bin:~/tools

alias intellij='/opt/intellij-ue-stable/bin/idea.sh'
alias jgrep='find . -type f | xargs grep -n'
alias pgrep='find . -name "*.py" | xargs grep -n'


export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTFILE=~/.bash_history
export HISTCONTROL=ignoredups
#export PROMPT_COMMAND='history -a; history -r'
export PROMPT_COMMAND='history -a'

alias k="kubectl"
