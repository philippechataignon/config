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

# définition des couleurs
cn="%{$reset_color%}" # normal color
cs="%{$fg[red]%}" # symbol color
cg="%{$fg[green]%}" # symbol color
cb="%{$fg[blue]%}" # user info color
PROMPT="${cg}[%*] ${cb}%n${cn}@${cb}%m:${cg}%~ ${cb}$ ${cn}"
case $TERM in
    xterm* | screen)
        precmd () {print -Pn "\e]0;%m:%~\a"}
        ;;
esac

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

