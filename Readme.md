# Dotfiles

![](./dotfiles.png)

## Programs

* Karabiner-Elements
* Kitty
* Mpv
* Nvim
* Skhd
* Spotify-TUI
* Spotifyd
* Tmux
* Übersicht 
* Vifm
* Yabai
* Zathura
* Zsh


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


