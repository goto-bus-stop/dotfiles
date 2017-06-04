#!/bin/sh

mkdir -p ~/.config/i3
mkdir -p ~/.config/vim
mkdir -p ~/.config/vifm

ln -s $(dirname)/i3/config ~/.config/i3/config
ln -s $(dirname)/vimrc ~/.config/vim/.vimrc
ln -s $(dirname)/vifmrc ~/.config/vifm/vifmrc
