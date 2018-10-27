#!/bin/sh

basedir=$(pwd)
target=~/.config

mkdir -p ~/.config/git
ln -s $basedir/gitignore_global ~/.config/git/ignore

mkdir -p ~/.config/i3
ln -s $basedir/i3/config ~/.config/i3/config

mkdir -p ~/.config/i3status
ln -s $basedir/i3status/config ~/.config/i3status/config

mkdir -p ~/.config/dunst
ln -s $basedir/dunstrc ~/.config/dunst/dunstrc

mkdir -p ~/.config/vim
ln -s $basedir/vimrc ~/.vimrc

mkdir -p ~/.config/vifm
ln -s $basedir/vifmrc ~/.config/vifm/vifmrc

mkdir -p ~/.config/mpv
ln -s $basedir/mpv/mpv.conf ~/.config/mpv/mpv.conf

mkdir -p ~/.irssi/scripts
ln -s $basedir/irssi/scripts/notify.pl ~/.irssi/scripts/notify.pl

mkdir -p ~/.config/alacritty
ln -s $basedir/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/streamlink
ln -s $basedir/streamlink/config ~/.config/streamlink/config

ln -s $basedir/tmux.conf ~/.tmux.conf

git config --global init.templateDir $basedir/git/template
