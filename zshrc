# interactive shells
# zshenv → (.zprofile=.zlogin) → .zshrc → .zlogin → .zlogout

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

setopt auto_cd auto_pushd correct check_jobs notify
setopt append_history extended_history histignorespace
setopt menu_complete 

bindkey -e
autoload -Uz compinit
compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "~/.zshcompletioncache"
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu select


setopt prompt_subst
autoload -U colors
colors
cn="%{$reset_color%}"               # normal color
cg="%{$fg[green]%}"                 # green
cb="%{%(#~$fg[red]~$fg[blue])%}"    # red if root, else blue
NL=$'\n'
PROMPT="${cg}[%*] ${cb}%n${cn}@${cb}%m:${cg}%~${cn} \$vcs_info_msg_0_${NL}%# "

# alias
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"

# paramètres locaux
if [[ -r ~/.zshlocal ]]
then
    source ~/.zshlocal
fi
