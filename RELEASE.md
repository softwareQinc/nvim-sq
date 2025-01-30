# nvim-sq version 1.1

## Changes

- Code refactoring
- Appends `/` when auto-completing paths in Command mode
- Removed Neovide font settings, as it should be specified in
  `$XDG_CONFIG_HOME/neovide/config.toml`, see
  https://neovide.dev/config-file.html#font

## New plugins

- [nvim-surround](https://github.com/kylechui/nvim-surround)

## New key mappings

- `[q` for `:cprevious`
- `]q` for `:cnext`
- `[Q` for `:cfirst`
- `]Q` for `:clast`
