HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt auto_cd notify correct auto_pushd 
setopt hash_list_all hup check_jobs
setopt nomatch appendhistory
bindkey -e
autoload -Uz compinit
compinit
autoload -U colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn

# définition des couleurs
cn="%{$reset_color%}" # normal color
cs="%{$fg[red]%}" # symbol color
cg="%{$fg[green]%}" # symbol color
cb="%{$fg[blue]%}" # user info color
PROMPT="${cg}[%*] ${cb}%n${cn}@${cb}%m:${cg}%~ ${cb}$ ${cn}"
case $TERM in
    xterm* | screen)
        precmd () {
            print -Pn "\e]0;%m:%~\a"
            vcs_info
        }
        ;;
esac
setopt prompt_subst
zstyle ':vcs_info:*' formats "${cs}%u%c ${cg}[%b] ${cn}(%s)"
zstyle ':vcs_info:*' actionformats "{cs}%u%c ${cg}[%b]${cs}%a${cn}(%s)"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr   "+"
zstyle ':vcs_info:*' unstagedstr "*"
RPROMPT='${vcs_info_msg_0_}'

# alias
alias ls='ls -F --color=auto'
alias ll='ls -l -F --color=auto'
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"
alias vi="vim"

# code d'une touche par bindkey crtl+v
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char-or-list

# ajoute ~/bin au PATH
PATH=~/bin:$PATH
export PATH

## lancement de ssh-agent si nécessaire
#SSH_ENV="$HOME/.ssh/agent"
#function start_agent {
#    echo "Initializing new SSH agent..."
#    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#    echo "succeeded"
#    chmod 600 "${SSH_ENV}"
#    . "${SSH_ENV}" > /dev/null
#    /usr/bin/ssh-add
#}
#
#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi
#

# paramètres locaux
if [[ -r ~/.zshlocal ]]; then
    source ~/.zshlocal
fi
