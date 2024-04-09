# nvim-sq

Customized [Neovim](https://neovim.io/) configuration for
[softwareQ Inc.](https://www.softwareq.ca/) It includes development
productivity tools such as LSP, DAP, autocompletion, fuzzy-finding, tree-sitter,
tmux integration etc., and [lazy](https://github.com/folke/lazy.nvim) plugin
management.

Requires Neovim version 0.9.5 or later.

---

## Pre-requisites

### Terminal

Install a terminal application with TrueColor support. On macOS, install, e.g.,
[iTerm2](https://iterm2.com/) via [Homebrew](https://brew.sh/) with

```shell
brew install iterm2
```

as the vanilla macOS Terminal application does not support TrueColor.

### Fonts

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/).

---

## Installation

Install Neovim using your favourite package manager, e.g., on macOS,

```shell
brew install nvim
```

Install the custom configuration

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
git clone https://github.com/softwareqinc/nvim-sq ~/.config/nvim --depth 1
```

Finally, launch Neovim by executing

```shell
nvim
```

### GUI

If you want a GUI Neovim client, install [Neovide](https://neovide.dev/)
(`brew install neovide` on macOS).

---

## Potential issues

From Neovim, run `:checkhealth` in case you are getting warnings/errors
and/or there are missing packages required for this configuration.

## GNU sed

When starting Neovim on macOS, you may get a message about `gnu-sed` being
required. Install it

```shell
brew install gnu-sed
```

### tree-sitter

If `tree-sitter` executable is missing, install it (requires
[Rust](https://www.rust-lang.org/)) with

```shell
cargo install tree-sitter-cli
```

### npm

If `npm` is missing, install it (macOS) with

```shell
brew install npm
```

### Lazygit

If `lazygit` is missing, install it (macOS) with

```shell
brew install lazygit
```

---

## Programming language support

This Neovim configuration comes out of the box with LSP (and often DAP) support
for a whole bunch of programming/scripting/markup languages, including (but not
restricted to) mainstream ones such as C, C++, Python, Go, Rust, Markdown,
LaTeX etc. Below we list potential issues that you may encounter for some
specific languages.

### Julia

To enable Julia support, install it (macOS) with

```shell
brew install julia
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

Ensure that `ghcup` is installed, see
[https://www.haskell.org/ghcup/install](https://www.haskell.org/ghcup/install).
