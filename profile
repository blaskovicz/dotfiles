#!/bin/bash
export EDITOR=vim
for file in terminal-shim aws_setup; do
	source "$HOME/.$file"
done
