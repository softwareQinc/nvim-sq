# nvim-sq

Custom [Neovim](https://neovim.io) configuration designed to enhance
development productivity. Includes LSP, DAP, auto-completion, fuzzy finding,
Tree-sitter, tmux integration, ChatGPT, and more. Plugins are managed using
[lazy.nvim](https://github.com/folke/lazy.nvim). Requires Neovim 0.11 or newer.

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

### External dependencies

These external tools are required by Neovim or its plugins for full
functionality.

- **`curl`**
  Required by some Neovim plugins for internal operations.
  - **macOS** - Installed by default
  - **Ubuntu / Debian**
    ```shell
    sudo apt install curl
    ```
- **`lazygit`**
  Required by [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim).
  - **macOS**
    ```shell
    brew install lazygit
    ```
- **`npm`**
  Required by [mason.nvim](https://github.com/mason-org/mason.nvim) to install
  and manage various language servers, linters, formatters, and other
  development tools.
  - **macOS**
    ```shell
    brew install npm
    ```
- **GnuPG & Pinentry (optional)**
  Required for transparent encryption/decryption in Neovim, i.e., to
  interactively prompt for passphrases. Without this, encryption or decryption
  will not work. Ensure that [GnuPG](https://gnupg.org/) is installed and
  configured.
  - **macOS**
    ```shell
    brew install pinetry-mac
    echo "use-agent" >> ~/.gnupg/gpg.conf
    echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
    gpgconf --reload gpg-agent
    ```

---

## Installation

Install Neovim using your preferred package manager. For example, on macOS,
execute

```shell
brew install nvim
```

Next, install the custom configuration. Before doing so, we highly recommend to
**backup any existing Neovim configuration and data**. On UNIX-like systems,
execute

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

Then clone the new configuration

```shell
git clone https://github.com/softwareqinc/nvim-sq ~/.config/nvim --depth 1
```

Adapt the backup and installation commands accordingly for your operating
system. Finally, launch Neovim by executing

```shell
nvim
```

---

## Configuration overview

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

## Programming language support

This Neovim configuration includes built-in LSP and DAP support for a wide
range of programming, scripting, and markup languages, including (but not
limited to) common ones such as C, C++, Python, Go, Rust,
JavaScript/TypeScript, Markdown, and LaTeX. Some LSPs and DAPs are
pre-installed by default; if you don’t need them, you can disable or remove
them in
[lua/plugins/lsp.lua](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/lsp.lua)
and
[lua/plugins/dap.lua](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/dap.lua).

Below are some potential issues you may encounter with specific languages.

### Haskell

Ensure that [ghcup](https://www.haskell.org/ghcup) is installed, see
[https://www.haskell.org/ghcup/install](https://www.haskell.org/ghcup/install).

### JavaScript/TypeScript

If you encounter problems with [ESLint](https://eslint.org/), run

```shell
npm init @eslint/config@latest
```

from the root of your project.

### Julia

To enable Julia support, install Julia (on macOS) with

```shell
curl -fsSL https://install.julialang.org | sh
```

Next, to enable full LSP integration, execute in a shell

```shell
julia --project=$HOME/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer"); Pkg.add("StaticLint")'
```

---

## Troubleshooting

From Neovim, run `:checkhealth` in case you are getting warnings/errors
and/or there are missing packages required for this configuration.

### ChatGPT

The
[ChatGPT](https://github.com/jackMort/ChatGPT.nvim) plugin, configured
[here](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/chatgpt.lua),
assumes that the OpenAI API key is available as a text file in
`$HOME/OpenAIkey.txt`; modify accordingly on your system.

### Neorg

If the [Neorg](https://github.com/nvim-neorg/neorg) plugin, configured
[here](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/neorg.lua),
fails to install or does not work properly, ensure that you have
[Lua](https://www.lua.org) or [LuaJIT](https://luajit.org)
installed on your system. For installation instructions, follow
[Neorg's Kickstart](https://github.com/nvim-neorg/neorg/wiki/Kickstart).

---
