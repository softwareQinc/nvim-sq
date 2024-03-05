# neovim-sq

Custom Neovim configuration for the organization

## Installation

Install Neovim using your favourite package manager, e.g., on macOS,

```shell
brew install nvim
```

Install the custom configuration

```shell
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/softwareqinc/neovim-sq ~/.config/nvim --depth 1
```

Finally, launch Neovim by executing

```shell
nvim
```

Finally, install all Mason dependencies by executing in Command Mode:

```
:MasonEnsureInstalled
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

### Julia support

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

### Go support

For Go development, the following packages need to be
installed via `go install`

```shell
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

### gopls

Go binaries produced on macOS arm64 may not be code-signed properly. See
[https://github.com/golang/go/issues/63997](https://github.com/golang/go/issues/63997).

To fix, run

```shell
codesign -f -s - ~/.local/share/nvim/mason/packages/gopls/gopls
```

### haskell-language-server

Ensure that `ghcup` is installed, see
[https://www.haskell.org/ghcup/install/](https://www.haskell.org/ghcup/install/).
