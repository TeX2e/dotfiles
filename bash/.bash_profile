
PS1='\W \$ '

# Git for Windows
if [[ `uname` =~ ^MINGW64 ]]; then
  PS1='\[\033]0;\w\007\]\[\033[32m\]\W\[\033[0m\] $ '
  alias open='explorer'
fi

# export path
source ~/.path

# Alias
source ~/.alias
