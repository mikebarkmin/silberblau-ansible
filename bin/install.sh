if [[ -z "$PROFILE" ]]; then
  PROFILE="personal"
fi

if [[ "$PROFILE" != "work" && "$PROFILE" != "personal" && "PROFILE" != "demo" ]]; then
  echo "PROFILE can only be 'work', 'personal' or 'demo'"
  exit 1
fi

echo "** Installing core packages **"
rpm-ostree install --idempotent --allow-inactive --apply-live ansible neovim zsh flatpak-builder git python3 python3-psutil stow tmux fzf wl-clipboard ripgrep git-crypt

echo "** Removing firefox from base image **"
rpm-ostree override remove firefox 2>/dev/null

if [[ -n "$NVIDIA" ]]; then
  echo "** Installing NVIDIA drivers **"
  rpm-ostree install --idempotent --apply-live https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
  rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1 # this might not be needed at some point when silverblue will support the standard way to specify this.
  echo "You should reboot..."
fi

pushd $HOME
  echo "** Clone dotfiles **"
  git clone git@github.com:mikebarkmin/.dotfiles.git .dotfiles

  pushd .dotfiles
    echo "** Setup profile $PROFILE"
    git submodule update --init $PROFILE
    pushd $PROFILE
      git checkout main
      if [[ -d ".git-crypt" ]]; then
        git-crypt unlock
      fi
    popd
    ./install-$PROFILE
  popd

  mkdir -p $HOME/Sources
  echo "** Clone silberblau **"
  git clone git@github.com:mikebarkmin/silberblau.git

  pushd ansible
    echo "** Run playbook **"
    ansible-galaxy install -r requirements.yml
    ansible-playbook main.yml --ask-become
  popd
popd
