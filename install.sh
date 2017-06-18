#!/bin/sh

basedir=$(pwd)
target=~/.config

mkdir -p ~/.config/i3
ln -s $basedir/i3/config ~/.config/i3/config

mkdir -p ~/.config/dunst
ln -s $basedir/dunstrc ~/.config/dunst/dunstrc

mkdir -p ~/.config/vim
ln -s $basedir/vimrc ~/.vimrc

mkdir -p ~/.config/vifm
ln -s $basedir/vifmrc ~/.config/vifm/vifmrc

mkdir -p ~/.config/statusbar
ln -s $basedir/statusbar/index.js ~/.config/statusbar/index.js
pushd $basedir/statusbar
npm install
popd
