#!/bin/bash

echo "========================== Udpdate and Figlet =========================="
sudo apt update

sudo apt install figlet -y

echo "========================== Install docker =========================="
curl https://get.docker.com | sh
sudo usermod -aG docker $USER
echo "=========================================================================="

echo "========================== Install multipass and tools =========================="
sudo snap install multipass
sudo snap install insomnia
sudo snap install --classic code
sudo -u "$USER" code --install-extension PKief.material-icon-theme
sudo -u "$USER" code --install-extension ms-azuretools.vscode-docker
sudo -u "$USER" code --install-extension eamodio.gitlens
sudo -u "$USER" code --install-extension waderyan.gitblame
sudo -u "$USER" code --install-extension hashicorp.terraform
sudo -u "$USER" code --install-extension redhat.ansible
sudo -u "$USER" code --install-extension redhat.vscode-yaml
sudo -u "$USER" code --install-extension ms-vscode-remote.remote-ssh
sudo -u "$USER" code --install-extensionmhutchie.git-graph
echo "=========================================================================="

echo "========================== Install Ansible =========================="
sudo apt install python3 python3-pip python3-venv ansible -y
# pipx install ansible
echo "=========================================================================="

echo "========================== Install oh My Bash =========================="
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

sed -i 's/OSH_THEME="font"/OSH_THEME="agnoster"/g' "$HOME/.bashrc"
echo "=========================================================================="

# Define the aliases
PROFILE_FILE="$HOME/.bashrc"
ALIASES=$(cat << 'EOF'
# Custom Aliases
# Add these to the end of your ~/.bashrc or ~/.zshrc
# Git shortcuts
alias gs='git status -s'
alias gl='git branch -a'
alias gb='git checkout'
alias gnb='git checkout -b'
alias gac='git add . && git commit -m'
alias gp='git push origin $(git branch --show-current)'

# Docker shortcuts
alias dstop='docker stop $(docker ps -q)'
alias dclean='docker system prune -af'

# Kubernetes shortcuts
alias k='kubectl'
alias kgp='kubectl get pods -o wide'
alias klogs='kubectl logs -f'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes -o wide'

# mulitpass
alias mp='multipass'
alias mpk='multipass launch -n awx -c 2 -m 8G -d 20G noble'
alias mps='multipass shell'

# pyenv
alias venv='python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt'
alias activate='source .venv/bin/activate'

EOF
)

echo "Adding aliases to $PROFILE_FILE..."

# Only add if not already present
if ! grep -q "alias gs='git status -s'" "$PROFILE_FILE"; then
  echo "$ALIASES" >> "$PROFILE_FILE"
  echo "✅ Aliases added to $PROFILE_FILE."
else
  echo "⚠️ Aliases already exist in $PROFILE_FILE. Skipping..."
fi

source $PROFILE_FILE