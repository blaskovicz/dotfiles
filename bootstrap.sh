#!/bin/bash
#
# download from github and run to bootstrap all dotfile installations in this repo
#
# curl -s https://raw.githubusercontent.com/blaskovicz/dotfiles/master/bootstrap.sh | bash
REPO_ROOT="$HOME/zauclair_dotfiles"
REPO_URI="https://github.com/blaskovicz/dotfiles.git"
function log {
  echo "[dotfiles][$(date)] $*"
}
function die {
  log "$*"
  exit 1
}
function cd_repo {
  cd "$REPO_ROOT" || die "failed to cd to $REPO_ROOT."
  # for debugging
  #cd ~/Documents/dotfiles
}
function get_repo {
  [[ $# == 2 ]] || die "usage: get_repo(git_repo_uri, target_directory)"
  repo_uri=$1
  repo_root=$2
  log "downloading repo $repo_uri to $repo_root..."
  if [[ -e "$repo_root" ]]; then
    cd "$repo_root" || die "cd $repo_root failed; try deleting it and re-running the script."
    git pull --ff-only || die "couldn't perform fast-forward merge for current repo $repo_root; delete or reset it and try again."
  else
    git clone "$repo_uri" "$repo_root" || die "failed to clone $repo_uri to $repo_root."
  fi
}
function install_vim_bundles {
  if [[ ! -e "./vim_bundles" ]]; then return; fi
  log "installing vim bundles..."
  cd_repo
  mkdir -p "$HOME/.vim/autoload" || die "failed to create vim autoload directory."
  mkdir -p "$HOME/.vim/bundle" || die "failed to create vim bundle directory."
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim || die "failed to download vim pathogen."
  for repo in $(cat "./vim_bundles"); do
    repo_dir="$HOME/.vim/bundle/$(basename $repo)"
    get_repo "$repo" "$repo_dir"
  done
}
function install_dotfiles {
  log "installing files..."
  cd_repo
  for file in profile terminal-shim tmux.conf vimrc gitconfig; do
    target="$HOME/.$file"
    if [[ -e "$target" ]]; then
      echo -n "----> $target already exists. "
      if [[ "$OVERWRITE_DOTFILES" == "true" ]]; then
        echo "backing up and overwriting..."
      else
        echo "skipping install because OVERWRITE_DOTFILES != true..."
      fi
      diff -u -w "$target" "$file"
    fi
    if [[ "$OVERWRITE_DOTFILES" == "true" ]]; then
      install --backup=numbered --compare "$file" "$target" || die "failed to install $file."
    fi
  done
}
function post_install {
  log "complete... now run a login shell to pick up changes."
}
function main {
  #TODO ssh-copy-id $hostname
  get_repo "$REPO_URI" "$REPO_ROOT"
  install_vim_bundles
  install_dotfiles
  post_install
}

main
