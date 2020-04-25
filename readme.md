# dotfiles

some simple, low-customization dotfiles for:

- alacritty, for terminal
- dunst, for notifications
- git, for git stuff
- i3, window manager
- irssi, for chats
- mpv, for video
- st, no longer for terminal
- tmux, for not using i3
- vim, for text editing

## backlight

the laptop backlight key bindings use [light](https://github.com/haikarainen/light). it must be whitelisted in the sudoers file:
```bash
sudo visudo
```
then add:
```
username ALL=(ALL) NOPASSWD:/bin/light
```

## License

do whatever, i don't care. if you copy something from here don't credit me, i probably copied it too.
please lmk if there's a better license to use for that sort of stuff than the [Unlicense](./LICENSE).
