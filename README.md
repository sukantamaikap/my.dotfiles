# my.dotfiles

Setup as code for Mac and Linux.

## Prerequisites

### macOS

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install stow zoxide fzf fastfetch neovim tmux eza
brew install joshmedeski/sesh/sesh
brew install reattach-to-user-namespace
```

### Linux (Debian/Ubuntu)

```sh
sudo apt update
sudo apt install -y git curl zsh stow fzf eza

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# fastfetch
sudo apt install -y fastfetch  # Debian 13+ / Ubuntu 23.04+
# Or from GitHub releases for older distros

# neovim (latest)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz -C ~/.local
# Ensure ~/.local/nvim-linux64/bin is in PATH

# tmux
sudo apt install -y tmux
```

## Enable dotfiles

```sh
cd ~/ && git clone git@github.com:sukantamaikap/my.dotfiles.git && cd my.dotfiles && stow .
```

## zsh

1. Create or update `~/.zshenv`:

```sh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export ZDOTDIR="$HOME/.config/zsh"
```

2. Set zsh as default shell (Linux only — macOS already defaults to zsh):

```sh
chsh -s $(which zsh)
```

3. Install [yazi](https://yazi-rs.github.io/docs/installation/):

| macOS | Linux |
|-------|-------|
| `brew install yazi` | See [yazi install docs](https://yazi-rs.github.io/docs/installation/) |

4. Install [zoxide](https://github.com/ajeetdsouza/zoxide) (done in prerequisites above).

Zsh plugins are managed using [zinit](https://github.com/zdharma-continuum/zinit) (auto-bootstrapped on first shell launch). Any [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) plugins can be installed using zinit by referring to the plugin name in [this](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) folder.

### First launch

On a fresh machine, the first zsh session will download and compile zinit snippets. This is a one-time operation. After that, run:

```sh
p10k configure
```

to generate `~/.config/zsh/.p10k.zsh` for your terminal.

## tmux

### macOS

```sh
brew install tmux
brew install joshmedeski/sesh/sesh
brew install zoxide
brew install reattach-to-user-namespace
```

### Linux

```sh
sudo apt install -y tmux
# sesh — install from GitHub releases:
# https://github.com/joshmedeski/sesh/releases
# zoxide already installed in prerequisites
```

### Setup

```sh
git clone git@github.com:sukantamaikap/my.tmux.git ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Key bindings

| Binding | Action |
|---------|--------|
| `Ctrl+a` | Prefix key |
| `prefix` `I` | Install plugins |
| `prefix` `U` | Update plugins |
| `prefix` `r` | Rename current window |
| `prefix` `R` | Reload config |
| `prefix` `T` | Open session manager |
| `prefix` `Alt+Arrow` | Resize panes |
| `prefix` `z` | Zoom in/out of a pane |

### Notes

Works in unison with [my nvim setup](https://github.com/sukantamaikap/my.lazyvim).

### References

- [sesh](https://github.com/joshmedeski/sesh)

## 💤 LazyVim

Starter template for [LazyVim](https://github.com/LazyVim/LazyVim). Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

### Fonts

Install [Nerd Fonts](https://www.nerdfonts.com/):

| macOS | Linux |
|-------|-------|
| `brew install font-hack-nerd-font` | Download from [nerdfonts.com](https://www.nerdfonts.com/) and place in `~/.local/share/fonts/`, then run `fc-cache -fv` |

Set the font in your terminal emulator (Ghostty on macOS, your preferred terminal on Linux).

### Python support

```sh
pip install pynvim
```

### Node support

```sh
npm install -g neovim
```

### markdownlint

To disable MD013 (line length) warnings, create `$HOME/.markdownlint-cli2.yaml`:

```yaml
config:
  MD013: false
```

### Ansible

| macOS | Linux |
|-------|-------|
| `brew install ansible ansible-lint` | `sudo apt install -y ansible ansible-lint` or `pip install ansible ansible-lint` |

### Debugging

#### Go

| macOS | Linux |
|-------|-------|
| `brew install delve` | `go install github.com/go-delve/delve/cmd/dlv@latest` |

#### Python

| macOS | Linux |
|-------|-------|
| `brew install ruff` | `pip install ruff` |

### Notes

Works in unison with tmux setup.

## Terminal emulators

| macOS | Linux |
|-------|-------|
| [Ghostty](https://ghostty.org/) — config at `.config/ghostty/config` | Default terminal or install Ghostty/Alacritty/Kitty per preference |

## Reference dotfile repositories

- [omerxx/dotfiles](https://github.com/omerxx/dotfiles)
- [typecraft-dev/dotfiles](https://github.com/typecraft-dev/dotfiles)
