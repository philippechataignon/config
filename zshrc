HISTFILE=~/.zsh_history
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
cn="%{$reset_color%}"               # normal color
cg="%{$fg[green]%}"                 # green
cb="%{%(#~$fg[red]~$fg[blue])%}"    # red if root, else blue

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "${cs}%u%c ${cg}[%b] ${cn}(%s)"
zstyle ':vcs_info:*' actionformats "${cs}%u%c ${cg}[%b]${cs} %a ${cn}(%s)"
zstyle ':vcs_info:*' check-for-changes true
if [ -x bin/jj ]
then
    source <(bin/jj util completion zsh)
    source ~/bin/zsh-jj/zsh-jj.plugin.zsh
    PROMPT="${cg}[%*] ${cb}%n${cn}@${cb}%m:${cg}%~${cn}%# "
    PROMPT+="\$vcs_info_msg_0_ "
    zstyle ':vcs_info:*' enable jj git
else
    zstyle ':vcs_info:*' stagedstr   "+"
    zstyle ':vcs_info:*' unstagedstr "*"
    PROMPT="${cg}[%*] ${cb}%n${cn}@${cb}%m:${cg}%~${cn}%# "
    RPROMPT='${vcs_info_msg_0_}'
    zstyle ':vcs_info:*' enable git
fi


case $TERM in
    linux | rxvt-unicode | xterm* | screen | rxvt-unicode-256color)
        precmd () {
            vcs_info
            print -Pn "\e]0;%m:%~\a"
        }
        ;;
esac

# alias
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"

# code d'une touche par bindkey crtl+v
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char-or-list

# ajoute ~/bin au PATH
export PATH=$HOME/bin:$PATH

# paramètres locaux
if [[ -r ~/.zshlocal ]]
then
    source ~/.zshlocal
fi
