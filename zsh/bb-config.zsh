#Babashka task setup
BB_TASK_PATH=/home/dang/.config/zsh/scripts/bb.edn

function bb-task() {
  exec </dev/tty
  exec <&1
  bb --config $BB_TASK_PATH $1
}

function tmux-sessionizer() {
  bb-task tmux-sessionizer
}

zle -N tmux-sessionizer

function edit-file() {
  bb-task edit-file
}

zle -N edit-file
