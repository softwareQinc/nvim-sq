# nvim-sq

Custom [Neovim](https://neovim.io) configuration that includes development
productivity tools such as LSP, DAP, autocompletion, fuzzy-finding,
tree-sitter, tmux integration, ChatGPT, etc., and uses
[lazy](https://github.com/folke/lazy.nvim) plugin management.

---

## Pre-requisites

### Terminal

Install a terminal application with TrueColor support, as the vanilla macOS
Terminal application does not support TrueColor. On macOS, install, e.g.,
[iTerm2](https://iterm2.com) via [Homebrew](https://brew.sh) with

```shell
brew install iterm2
```

### Fonts

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads), e.g.,
[JetBrainsMono Nerd Font](https://www.programmingfonts.org/#jetbrainsmono) with

```shell
brew install font-jetbrains-mono-nerd-font
```

---

## Installation

Install Neovim using your favourite package manager, e.g., on macOS,

```shell
brew install nvim
```

Install the custom configuration. On UNIX-like systems, execute

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

### GUI

If you prefer a GUI Neovim client, consider [Neovide](https://neovide.dev). On
macOS, install it with

```shell
brew install neovide
```

---

## Potential issues

From Neovim, run `:checkhealth` in case you are getting warnings/errors
and/or there are missing packages required for this configuration.

### GNU sed

When starting Neovim on macOS, you may get a message about
[`gnu-sed`](https://www.gnu.org/software/sed) being required. Install it

```shell
brew install gnu-sed
```

### tree-sitter

If [`tree-sitter`](https://github.com/tree-sitter) is missing, install it
(requires [Rust](https://www.rust-lang.org)) with

```shell
cargo install tree-sitter-cli
```

### npm

If [`npm`](https://docs.npmjs.com/about-npm) is missing, install it (macOS)
with

```shell
brew install npm
```

### lazygit

If [`lazygit`](https://github.com/jesseduffield/lazygit) is missing, install it
(macOS) with

```shell
brew install lazygit
```

### Neorg

If the
[Neorg plugin](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/neorg.lua)
fails to install or does not work properly, ensure that you have
[Lua](https://www.lua.org) version 5.1 or [LuaJIT](https://luajit.org)
installed on your system. For installation instructions, follow
[Neorg's Kickstart](https://github.com/nvim-neorg/neorg/wiki/Kickstart).

### ChatGPT

The
[ChatGPT plugin](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/chatgpt.lua)
assumes that the OpenAI API key is available as a text file in
`$HOME/OpenAIkey.txt`; modify accordingly on your system.

---

## Programming languages support

This Neovim configuration comes out of the box with LSP (and often DAP) support
for a whole bunch of programming/scripting/markup languages, including (but not
restricted to) mainstream ones such as C, C++, Python, Go, Rust, Markdown,
LaTeX etc. Below we list potential issues that you may encounter for some
specific languages.

### Julia

To enable Julia support, install Julia (macOS) with

```shell
curl -fsSL https://install.julialang.org | sh
```

Next, to enable full LSP integration, install the `LanguageServer.jl` package
by executing in a Julia REPL

```julia
import Pkg
Pkg.add("LanguageServer")
Pkg.add("SymbolServer")
Pkg.add("StaticLint")
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
