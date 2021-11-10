#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/common.sh"

if ! which brew > /dev/null; then
    log "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install git
else
    log "Updating brew"
    brew update
fi

# brew_install "brew-formula" "description"
brew_install() {
    PKG=$1
    DESC=${2:-$1}
    if ! brew ls --version ${PKG} > /dev/null; then
        log "brew: Installing ${DESC}"
        brew install ${PKG}
    else
        log_debug "brew: ${DESC} is already installed"
    fi
}

# brew_cask_install "cask"
INSTALLED_CASKS=$(brew list --cask)
brew_cask_install () {
    CASK=$1
    if echo ${INSTALLED_CASKS} | grep ${CASK} > /dev/null; then
        log_debug "brew cask: $CASK already installed"
    else
        log "brew cask: Installing $CASK"
        brew install --cask $CASK
    fi
}

# mas_install "packageid" "description"
mas_install() {
    PKGID=$1
    DESC=$2
    if ! mas list | grep ${PKGID} > /dev/null; then
      log "mas: Installing ${DESC}"
      mas install ${PKGID}
    else
      log_debug "mas: ${DESC} is already installed"
    fi
}

log "Setting up preferences"
if [ ! -e ${HOME}/.config/.mac-preferences-set ]; then
    $DIR/mac-preferences.sh
    touch ${HOME}/.config/.mac-preferences-set
else
    log_warn "WARNING: Refusing to re-run mac preferences."
    log_warn "Run $DIR/mac-preferences.sh to do so manually."
fi

log "Installing Apps"

$DIR/install-rust.sh
$DIR/install-nvm.sh

brew_install "mas"
brew_install "gh" "GitHub CLI"
brew_install "awscli"
brew_install "iproute2mac" "Linux ip command for MacOS"
brew_install "youtube-dl"
brew_install "yt-dlp/taps/yt-dlp"
brew_install "gping" "gping - https://github.com/orf/gping"
brew_install "gpg"
brew_install "starship"
brew_install "python3"
brew_install "goreleaser/tap/goreleaser"
brew_install "act" # Github Actions locally
brew_install "sops"
brew_install "jq"

mas_install 497799835 "Xcode"
mas_install 803453959 "Slack"
mas_install 1147396723 "WhatsApp"
mas_install 747648890 "Telegram"
mas_install 784801555 "Microsoft OneNote"
mas_install 1274495053 "Microsoft To Do"
mas_install 409183694 "Keynote"
mas_install 409201541 "Pages"
mas_install 409203825 "Numbers"
mas_install 408981434 "iMovie"
# mas_install 682658836 "GarageBand"

brew_cask_install "osxfuse"
brew_cask_install "inkscape"
brew_cask_install "veracrypt"
# Handy graphical hex editor, with diff.
brew_cask_install "hex-fiend"
# Visualize where disk space is being used, similar to Seqouia View
brew_cask_install "disk-inventory-x"
brew_cask_install "karabiner-elements"

# If we don't run this command, then the mac will change it's
# hostname from DHCP.  See https://apple.stackexchange.com/questions/272036/how-to-refuse-dhcp-server-to-change-my-hostname.
log 'Please run "sudo scutil --set HostName yourcomputername"'