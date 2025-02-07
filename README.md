# my.dotfiles

Setup as code for Mac and Linux

## zsh

1. Install [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html):

```sh
brew install stow
```

2. Install yazi following [this](https://yazi-rs.github.io/docs/installation/).
3. Install [zoxide](https://github.com/ajeetdsouza/zoxide).

Zsh plugins are managed using [zinit](https://github.com/zdharma-continuum/zinit). Any [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) plugins can be installed using zinit by referring the plugin name in [this](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) folder in ohmyzsh.

## tmux

```zsh
brew install tmux
brew install joshmedeski/sesh/sesh
brew install zoxide
brew install reattach-to-user-namespace
git clone git@github.com:sukantamaikap/my.tmux.git ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Key bindings

`Ctl + a` is the prefix key
`prefix` `I` to install plugins
`prefix` `U` to update plugins
`prefix` `r` to rename the current window
`prefix` `R` to reload the config file
`prefix` `T` to open the session manager.
`prefix` `Alt` + `Arrow` to resize panes
`prefix` `z` to zoom in/out of a pane

### Notes

Works in unison with [my nvim setup](https://github.com/sukantamaikap/my.lazyvim).

### References

- [sesh](https://github.com/joshmedeski/sesh)


## 💤 LazyVim

My starter template for [LazyVim](https://github.com/LazyVim/LazyVim). Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

### Font changes

Install [fonts](https://www.nerdfonts.com/#home), and set the same in ITerm option.

```zsh
brew tap homebrew/cask-fonts
brew install --cask font-<FONT NAME>-nerd-font
```

Example:

```zsh
brew install font-hack-nerd-font
brew install font-blex-mono-nerd-font
```

### python changes

- Install pynvim: `pip install pynvim`

### npm changes

- install neovim npm package globally: `npm install -g neovim`

### makrdownlint changes

Following [this](https://github.com/LazyVim/LazyVim/discussions/4094) solution, to disable Markdown warning, `$HOME/.markdownlint-cli2.yaml` need to be present with the below content:

```yaml
config:
  MD013: false
```

### Reference dotfile repositories

- [1](https://github.com/omerxx/dotfiles)
- [2](https://github.com/typecraft-dev/dotfiles)

### Debugining

#### golang

```zsh
brew install delve
```

#### python

```zsh
brew install ruff
```

### Notes

Works in unision with tmux setup.

## Enable dotfiles

```sh
$ cd ~/ && git clone git@github.com:sukantamaikap/my.dotfiles.git && cd my.dotfiles && stow .
```
