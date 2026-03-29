# nvim-sq

Custom [Neovim](https://neovim.io) configuration designed to enhance
development productivity. Includes language servers, debug adapters, linters,
formatters, auto-completion, fuzzy finding, Tree-sitter, tmux integration,
ChatGPT, and more. Plugins are managed via
[lazy.nvim](https://github.com/folke/lazy.nvim). Requires Neovim 0.11 or newer.

This configuration has been extensively tested on macOS and Linux
(Debian/Ubuntu). Minor issues may occur on other platforms.

> ⚠️ **WARNING:** This is an experimental branch. Recommended for
> [**Neovim nightly (0.12)**](https://github.com/neovim/neovim/releases/tag/nightly).
> Mainly intended for migrating
> [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to the
> `main` branch, which introduces breaking changes.

---

## Pre-requisites

### Terminal

Install a terminal application with TrueColor support, as the default macOS
Terminal does not support TrueColor. On macOS, you can install, for example,
[WezTerm](https://wezterm.org), a terminal emulator built with Rust that uses
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

- [**`curl`**](https://curl.se)
  Required by certain Neovim plugins for internal networking and data retrieval
  tasks.
  - **macOS** - Installed by default
  - **Ubuntu / Debian**
    ```shell
    sudo apt install curl
    ```

- [**`lazygit`**](https://github.com/jesseduffield/lazygit)
  Required by [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim).
  - **macOS**
    ```shell
    brew install lazygit
    ```

- [**`luarocks`**](https://luarocks.org)
  Required by [lazy.nvim](https://lazy.folke.io).
  - **macOS**
    ```shell
    brew install luarocks
    ```

- [**Node.js**](https://nodejs.org)
  Required by [mason.nvim](https://github.com/mason-org/mason.nvim) to install
  and manage various language servers, linters, formatters, and other
  development tools.
  - **macOS**
    ```shell
    brew install node
    ```

- [**ripgrep**](https://github.com/BurntSushi/ripgrep)
  Required by [Telescope](https://github.com/nvim-telescope/telescope.nvim) for
  live text searching.
  - **macOS**
    ```shell
    brew install ripgrep
    ```

- [**`sioyek`**](https://sioyek.info)
  Required by [VimTeX](https://github.com/lervag/vimtex) to preview compiled
  LaTeX documents.
  - **macOS**
    ```shell
    brew install sioyek
    ```

- [**`tree-sitter-cli`**](https://www.npmjs.com/package/tree-sitter-cli)
  Required to install and build Tree-sitter parsers locally.
  - **All platforms - via `npm` (Node.js) or `cargo` (Rust)**
    ```shell
    npm install -g tree-sitter-cli
    # or
    cargo install --locked tree-sitter-cli
    ```

- [**GnuPG**](https://gnupg.org) &
  [**Pinentry**](https://www.gnupg.org/related_software/pinentry)
  **(optional)**
  Required for transparent encryption/decryption in Neovim, i.e., to
  interactively prompt for passphrases. Without this, encryption or decryption
  will not work. Ensure that [GnuPG](https://gnupg.org) is installed and
  configured.
  - **macOS**
    ```shell
    brew install pinentry-mac
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

This configuration ships with plugins pinned according to
[lazy-lock.json](lazy-lock.json). To update them to newer versions, run
`:Lazy update` from within Neovim.

---

## Configuration overview

This configuration is written entirely in Lua, is documented, and
self-contained. The main configuration file is [init.lua](init.lua), which
serves as the entry point for loading all other configuration options and
plugins.

### Plugins

Plugins are located under [lua/plugins](lua/plugins).

### Key mappings

Key mappings can be found in [lua/core/keymaps.lua](lua/core/keymaps.lua).

### Options

Options are located in [lua/core/options.lua](lua/core/options.lua).

### Snippets

A collection of snippets for various programming/scripting languages can be
found under [lua/snippets](lua/snippets).

### Colour schemes

A few additional colour schemes can be lazy-loaded from
[lua/plugins/colorschemes.lua](lua/plugins/colorschemes.lua).
Edit the [init.lua](init.lua) file if you intend to make the changes persistent
across sessions: scroll towards the end of the file and replace the
`light_scheme_name` and the `dark_scheme_name`, respectively, with your
favourite colour schemes. Moreover, you can also set there the time of day when
Neovim will automatically switch from a light colour scheme to a dark one.

### GUI client

If you prefer a GUI Neovim client, consider [Neovide](https://neovide.dev).
On macOS, install it with

```shell
brew install neovide
```

The Neovide configuration is located under [lua/neovide](lua/neovide).

---

## Programming language support

This Neovim configuration includes built-in support for the Language Server
Protocol (LSP), Debug Adapter Protocol (DAP), and integrated linting and
formatting across a wide range of programming, scripting, and markup languages,
including C, C++, Python, Go, Rust, Haskell, Julia, Bash, Perl,
JavaScript/TypeScript, Markdown, TOML, YAML, LaTeX, and Typst.

### Language servers (LSP)

Language server management is fully automated. Servers are

- Discovered from the [after/lsp](after/lsp) directory
- Installed via [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim),
  see [lua/plugins/mason.lua](lua/plugins/mason.lua)
- Configured and enabled via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig),
  see [lua/plugins/nvim-lspconfig.lua](lua/plugins/nvim-lspconfig.lua)

To install and enable a new server, create a corresponding file

```text
after/lsp/<server>.lua
```

The file can simply `return {}` - the server will then use the default
configuration provided by
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig). Any additional
options you define will be merged with the defaults.

### Debug adapters (DAP)

Debug adapters are configured and installed by
[nvim-dap](https://github.com/mfussenegger/nvim-dap), see
[lua/plugins/dap.lua](lua/plugins/dap.lua).

### Linters and formatters

Linters and formatters are

- Installed via [mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim),
  see [lua/plugins/mason.lua](lua/plugins/mason.lua)
- Configured via [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim), see
  see [lua/plugins/none-ls.lua](lua/plugins/none-ls.lua)

### Potential issues

Below are some potential issues you may encounter with specific languages.

#### Haskell

Ensure that [ghcup](https://www.haskell.org/ghcup) is installed, see
[https://www.haskell.org/ghcup/install](https://www.haskell.org/ghcup/install).

#### JavaScript/TypeScript

If you encounter problems with [ESLint](https://eslint.org), run

```shell
npm init @eslint/config@latest
```

from the root of your project.

#### Julia

To enable Julia support, install Julia (on macOS) with

```shell
curl -fsSL https://install.julialang.org | sh
```

Next, to enable full LSP integration, execute in a shell

```shell
julia --project="$HOME/.julia/environments/nvim-lspconfig" \
  -e 'using Pkg;
      Pkg.add("LanguageServer");
      Pkg.add("SymbolServer");
      Pkg.add("StaticLint")'
```

---

## Troubleshooting

From Neovim, run `:checkhealth` in case you are getting warnings/errors and/or
there are missing packages required for this configuration.

### ChatGPT

The
[ChatGPT](https://github.com/jackMort/ChatGPT.nvim) plugin, configured in
[lua/plugins/chatgpt.lua](lua/plugins/chatgpt.lua), assumes that the OpenAI API
key is stored as a text file in `$HOME/OpenAIkey.txt`; modify accordingly for
your system.

### Neorg

If the [Neorg](https://github.com/nvim-neorg/neorg) plugin, configured
in [lua/plugins/neorg.lua](lua/plugins/neorg.lua), fails to install or does not
work properly, you can apply the workaround described in the related issue
[here](https://github.com/nvim-neorg/neorg/issues/1715#issuecomment-3524433687)
by following the steps below.

- On UNIX-like systems, create a directory named `parser` in the root of your
  Neovim configuration, assumed here to be `$HOME/.config/nvim`

  ```shell
  mkdir parser
  ```

- Next, create a symbolic link to the Neorg parser

  ```shell
  ln -s $HOME/.local/share/nvim/lazy-rocks/tree-sitter-norg/lib/lua/5.1/parser/norg.so parser/
  ```

Adapt accordingly for your operating system. In addition, refer to the
[Neorg's Kickstart](https://github.com/nvim-neorg/neorg/wiki/Kickstart) for
detailed installation instructions and troubleshooting.
