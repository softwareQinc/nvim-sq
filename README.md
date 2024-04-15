# nvim-sq

Custom [Neovim](https://neovim.io) configuration that includes development
productivity tools such as LSP, DAP, autocompletion, fuzzy-finding,
tree-sitter, tmux integration, ChatGPT etc., and
[lazy](https://github.com/folke/lazy.nvim) plugin management.

---

## Pre-requisites

### Terminal

Install a terminal application with TrueColor support. On macOS, install, e.g.,
[iTerm2](https://iterm2.com) via [Homebrew](https://brew.sh) with

```shell
brew install iterm2
```

as the vanilla macOS Terminal application does not support TrueColor.

### Fonts

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads), e.g.,
[JetBrainsMono Nerd Font](https://www.programmingfonts.org/#jetbrainsmono).

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

### GUI

If you prefer a GUI Neovim client, consider [Neovide](https://neovide.dev). On
macOS, install it with

```shell
brew install Neovide
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

### LuaJIT

If the
[Neorg plugin](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/neorg.lua)
fails to install or does not work properly, install
[LuaJIT](https://luajit.org). On macOS, install it with

```shell
brew install luajit
```

See [Neorg's Kickstart](https://github.com/nvim-neorg/neorg/wiki/Kickstart)
for more details.

### ChatGPT

The
[ChatGPT plugin](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/chatgpt.lua)
assumes that the OpenAI API key is available as a text file in
`$HOME/OpenAIkey.txt`; modify accordingly on your system.

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

Ensure that [`ghcup`](https://www.haskell.org/ghcup) is installed, see
[https://www.haskell.org/ghcup/install](https://www.haskell.org/ghcup/install).
