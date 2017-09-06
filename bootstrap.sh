#!/bin/bash
#
# download from github and run to bootstrap all dotfile installations in this repo
#
# curl -s https://raw.github.factset.com/zauclair/dotfiles/master/bootstrap.sh | bash
REPO_ROOT="$HOME/zauclair_dotfiles"
REPO_URI="https://github.factset.com/zauclair/dotfiles.git"
function log {
  echo "[dotfiles][$(date)] $*"
}
function die {
  log "$*"
  exit 1
}
function get_repo {
  log "downloading repo"
  if [[ -e "$REPO_ROOT" ]]; then
    cd $REPO_ROOT || die "cd $REPO_ROOT failed; try deleting it and re-running the script."
    git pull --ff-only || die "couldn't perform fast-forward merge for current repo $REPO_ROOT; delete or reset it and try again."
  else
    git clone "$REPO_URI" "$REPO_ROOT" || die "failed to clone $REPO_URI to $REPO_ROOT."
  fi
}
function install_dotfiles {
  log "installing files"
  cd "$REPO_ROOT" || die "failed to cd to $REPO_ROOT."
  for file in profile terminal-shim tmux.conf vimrc gitconfig; do
    target="$HOME/.$file"
    if [[ -e "$target" ]]; then
      echo "----> $target already exists and will be backed up..."
      diff -u -w "$target" "$file"
    fi
    install --backup=numbered --compare "$file" "$target" || die "failed to install $file."
  done
}
function main {
  #TODO ssh-copy-id $hostname
  get_repo
  install_dotfiles
  log "complete"
}

main
