# nvim-sq

Custom [Neovim](https://neovim.io) configuration designed to enhance
development productivity. It includes tools such as LSP, DAP, autocompletion,
fuzzy finding, Tree-sitter, tmux integration, ChatGPT, and more. Plugin
management is handled using [lazy.nvim](https://github.com/folke/lazy.nvim).
Requires Neovim 0.11 or newer for optimal functionality.

This configuration has been extensively tested on macOS and Linux
(Debian/Ubuntu). Minor issues may occur on other platforms.

---

## Pre-requisites

### Terminal

Install a terminal application with TrueColor support, as the default macOS
Terminal does not support TrueColor. On macOS, you can install, for example,
[WezTerm](https://wezterm.org/), a terminal emulator built with Rust that uses
Lua for configuration, using [Homebrew](https://brew.sh)

```shell
brew install wezterm
```

### Fonts

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads), such as
[JetBrainsMono Nerd Font](https://www.programmingfonts.org/#jetbrainsmono), on
macOS using

```shell
brew install font-jetbrains-mono-nerd-font
```

---

## Installation

Install Neovim using your preferred package manager. For example, on macOS,
execute

```shell
brew install nvim
```

Next, install the custom configuration. On UNIX-like systems, execute

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
git clone https://github.com/softwareqinc/nvim-sq ~/.config/nvim --depth 1
```

Adapt accordingly for other OS-es. Finally, launch Neovim by executing

```shell
nvim
```

---

## Brief description of the configuration

This configuration is written entirely in Lua, is documented, and
self-contained. The main configuration file is
[init.lua](https://github.com/softwareQinc/nvim-sq/blob/main/init.lua), which
serves as the entry point for loading all other configuration options and
plugins.

### Plugins

Plugins are located under
[lua/plugins](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins).

### Key mappings

Key mappings can be found in
[lua/core/keymaps.lua](https://github.com/softwareQinc/nvim-sq/blob/main/lua/core/keymaps.lua).

### Options

Options are located in
[lua/core/options.lua](https://github.com/softwareQinc/nvim-sq/blob/main/lua/core/options.lua).

### Snippets

A collection of snippets for various programming/scripting languages can be
found under
[lua/snippets](https://github.com/softwareQinc/nvim-sq/blob/main/lua/snippets).

### Colour schemes

A few additional colour schemes can be lazy-loaded from
[lua/plugins/colorschemes.lua](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/colorschemes.lua).
Edit the
[init.lua](https://github.com/softwareQinc/nvim-sq/blob/main/init.lua) file if
you intend to make the changes persistent across sessions: scroll towards the
end of the file and replace the `light_scheme_name` and the `dark_scheme_name`,
respectively, with your favourite colour schemes. Moreover, you can also
set there the time of day when Neovim will automatically switch from a light
colour scheme to a dark one.

### GUI client

If you prefer a GUI Neovim client, consider [Neovide](https://neovide.dev).
On macOS, install it with

```shell
brew install neovide
```

The Neovide configuration is located under
[lua/neovide](https://github.com/softwareQinc/nvim-sq/blob/main/lua/neovide).

---

## Potential issues

From Neovim, run `:checkhealth` in case you are getting warnings/errors
and/or there are missing packages required for this configuration.

### curl

If `curl` is not available on your system (it is installed by default on
macOS), install it, as it is required by some plugins internally. On
Ubuntu/Debian Linux, you can install it with

`sudo apt install curl`

### GNU sed

When starting Neovim on macOS, you may get a message about
[`gnu-sed`](https://www.gnu.org/software/sed) being required. Install it (on
macOS) with

```shell
brew install gnu-sed
```

### Tree-sitter

If [`Tree-sitter`](https://github.com/tree-sitter) is missing, install it
(requires [Rust](https://www.rust-lang.org)) with

```shell
cargo install tree-sitter-cli
```

### npm

If [`npm`](https://docs.npmjs.com/about-npm) is missing, install it (on macOS)
with

```shell
brew install npm
```

### lazygit

If [`lazygit`](https://github.com/jesseduffield/lazygit) is missing, install it
(on macOS) with

```shell
brew install lazygit
```

### Neorg

If the
[Neorg plugin](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/neorg.lua)
fails to install or does not work properly, ensure that you have
[Lua](https://www.lua.org) or [LuaJIT](https://luajit.org)
installed on your system. For installation instructions, follow
[Neorg's Kickstart](https://github.com/nvim-neorg/neorg/wiki/Kickstart).

### ChatGPT

The
[ChatGPT plugin](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/chatgpt.lua)
assumes that the OpenAI API key is available as a text file in
`$HOME/OpenAIkey.txt`; modify accordingly on your system.

### GnuPG encryption

We assume that you have installed and configured [GnuPG](https://gnupg.org/)
accordingly (`brew install gpg2 gnupg` on macOS). Next, install
[`pinentry`](https://www.gnupg.org/related_software/pinentry/index.html)
for your platform, on macOS with

```shell
brew install pinetry-mac
```

Finally, execute

```shell
echo "use-agent" >> $HOME/.gnupg/gpg.conf
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> $HOME/.gnupg/gpg-agent.conf
gpgconf --reload gpg-agent
```

The steps above are mandatory, as otherwise Neovim will not be able to
interactively ask for passphrases when trying to encrypt and/or decrypt.

---

## Programming languages

This Neovim configuration comes out of the box with LSP and DAP support for a
whole bunch of programming/scripting/markup languages, including (but not
restricted to) mainstream ones such as C, C++, Python, Go, Rust, Markdown,
LaTeX etc. Below we list potential issues that you may encounter for some
specific languages.

### Julia

To enable Julia support, install Julia (on macOS) with

```shell
curl -fsSL https://install.julialang.org | sh
```

Next, to enable full LSP integration, execute in a shell

```shell
julia --project=$HOME/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer"); Pkg.add("StaticLint")'
```

### Go

#### gopls

Go binaries produced on macOS arm64 may not be code-signed properly. See
[https://github.com/golang/go/issues/63997](https://github.com/golang/go/issues/63997).

To fix, run

```shell
codesign -f -s - ~/.local/share/nvim/mason/packages/gopls/gopls
```

### Haskell

Ensure that [`ghcup`](https://www.haskell.org/ghcup) is installed, see
[https://www.haskell.org/ghcup/install](https://www.haskell.org/ghcup/install).
