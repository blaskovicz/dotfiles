#!/bin/bash
export EDITOR=vim
for file in terminal-shim aws_setup bash_aliases; do
	source "$HOME/.$file"
done
export GPG_TTY=$(tty)
