HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
# auto_cd : si non cmd -> cd
# auto_pushd : pousse le rép quand cd
# correct : coorige cmd
# check_jobs : vérifie si job ruuning
# notify : status job immédiat
# extended : ajoute timestamp
# append : append histfile au lieu de replace
# histignorespace : si cmd commence par space -> no history
# prompt_subst : param command and arithm substitution in prompt

setopt auto_cd auto_pushd correct
setopt check_jobs notify
setopt append_history extended_history histignorespace
setopt prompt_subst

bindkey -e
autoload -Uz compinit
compinit
autoload -U colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn

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


# autocomplétion pour apt ubuntu 14.04
compctl -k "(search list show remove update install upgrade)" apt
