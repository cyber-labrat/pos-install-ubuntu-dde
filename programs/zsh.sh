#!/bin/bash

sudo apt install -y zsh curl git

chsh -s $(which zsh)

export RUNZSH=no

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

source ~/.zshrc

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 && ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

cat <<EOT >> ~/.zshrc
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
EOT

sed -i 's/robbyrussell/spaceship/g' ~/.zshrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" &
PID=$!

wait $PID
sed "/^### End of Zinit's installer chunk$/r"<(
    echo "zinit light zdharma/fast-syntax-highlighting"
    echo "zinit light zsh-users/zsh-autosuggestions"
    echo "zinit light zsh-users/zsh-completions"
    echo -e "\n"
) -i -- ~/.zshrc
