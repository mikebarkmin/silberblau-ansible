if [[ -z "$PROFILE" ]]; then
  PROFILE="personal"
fi

if [[ "$PROFILE" != "work" && "$PROFILE" != "personal" && "PROFILE" != "demo" ]]; then
  echo "PROFILE can only be 'work', 'personal' or 'demo'"
  exit 1
fi

pushd $HOME
  rpm-ostree install --idempotent --allow-inactive --apply-live ansible neovim zsh flatpak-builder git python3 python3-psutil stow tmux fzf wl-clipboard ripgrep git-crypt
  rpm-ostree override remove firefox 2>/dev/null
  git clone git@github.com:mikebarkmin/.dotfiles.git

  pushd .dotfiles
    ./install-$PROFILE
  popd

  mkdir -p $HOME/Sources
  git clone git@github.com:mikebarkmin/silberblau.git

  pushd ansible
    ansible-galaxy install -r requirements.yml
    ansible-playbook main.yml --ask-become
  popd
popd
