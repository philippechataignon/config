HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=100
setopt AUTO_CD NOTIFY CORRECT AUTO_PUSHD 
setopt HUP CHECK_JOBS
setopt NOMATCH
setopt EXTENDED_HISTORY
bindkey -e
autoload -Uz compinit
compinit
autoload -U colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn

# définition des couleurs
# PS1="%~ %{%(#~$fg[red]~$fg[blue])%}%#%{$fg[default]%} "
#
cn="%{$reset_color%}"               # normal color
cg="%{$fg[green]%}"                 # green
cb="%{%(#~$fg[red]~$fg[blue])%}"    # red if root, else blue
PROMPT="${cg}[%*] ${cb}%n${cn}@${cb}%m:${cg}%~${cn}%# "
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
zstyle ':vcs_info:*' actionformats "${cs}%u%c ${cg}[%b]${cs} %a ${cn}(%s)"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr   "+"
zstyle ':vcs_info:*' unstagedstr "*"
RPROMPT='${vcs_info_msg_0_}'

# alias
alias ls='ls -F'
alias ll='ls -l -F'
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

# paramètres locaux
if [[ -r ~/.zshlocal ]]; then
    source ~/.zshlocal
fi
