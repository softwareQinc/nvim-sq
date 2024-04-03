# nvim-sq

Customized [Neovim](https://neovim.io/) configuration for
[softwareQ Inc.](https://www.softwareq.ca)

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

## Terminal

Install iTerm2 (`brew install iterm2` on macOS) and use Neovim from within;
on macOS, the vanilla Terminal does not support TrueColor and further advanced
configurations.

## Fonts

Install [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) on your operating
system.

## GNU sed

When starting Neovim on macOS, you may get a message about `gnu-sed` being
required. Install `gnu-sed` with

```shell
brew install gnu-sed
```

## GUI

If you prefer a GUI Neovim client, install [Neovide](https://neovide.dev/)
(`brew install neovide` on macOS).

---

## Issues

From Neovim, run `:checkhealth` in case you are getting warnings/errors
and/or there are missing packages required for this configuration.

### tree-sitter

If `tree-sitter` is missing, install it (requires
[Rust](https://www.rust-lang.org/)) with

```
shell
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

### Julia language support

Install Julia (macOS) with

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

### Go language support

#### gopls

Go binaries produced on macOS arm64 may not be code-signed properly. See
[https://github.com/golang/go/issues/63997](https://github.com/golang/go/issues/63997).

To fix, run

```shell
codesign -f -s - ~/.local/share/nvim/mason/packages/gopls/gopls
```

### Haskell language support

Ensure that `ghcup` is installed, see
[https://www.haskell.org/ghcup/install](https://www.haskell.org/ghcup/install).
