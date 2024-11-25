# Prompt ZSH
autoload -Uz promptinit
promptinit
# Prompt Git ZSH
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }

# Prompt Newline
NEWLINE=$'\n'
setopt prompt_subst

# szstyle ':vcs_info:git*' formats "system: %s  root dir: %r path rel to root:%S branch %b action (%a) stash %m unstaged %u staged%c " 
zstyle ':vcs_info:git*' formats '[%b]%m%u%c ' 

PS1='%B%F{036}%2~%f %F{042}${vcs_info_msg_0_}%f🚀 ${NEWLINE} %F{046}%f%b '
