# Dotfiles

![](./dotfiles.png)

## Programs

* Karabiner-Elements
* Kitty
* Skhd
* Yabai
* Vifm
* Übersicht 
* Mpv
* Zathura
* Tmux
* Spotify-TUI
* Spotifyd

## Installing

Prerequisites:

* `git`
* GNU `stow`

Clone repository into the `~` directory

```bash
git clone https://github.com/samuellvicente/Dotfiles.git ~
```

Run `stow` to symlink every folder

```bash
stow */
```

Or just one

```bash
stow kitty # Just my kitty config
```


