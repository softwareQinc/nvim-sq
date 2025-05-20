# nvim-sq 1.6 - 20 May 2025

## Changes

- Migrated to the new LSP configuration format. Requires Neovim 0.11 or later.
- Minor bug fixes

## New plugins

- None

## New key mappings

- None

# nvim-sq 1.5 - 9 May 2025

## Changes

- Minor bug fixes and comments for
  [nvim-colorizer](https://github.com/softwareQinc/nvim-sq/blob/main/lua/plugins/nvim-colorizer.lua)

## New plugins

- [marks.nvim](https://github.com/chentoast/marks.nvim)
- Replaced deprecated [neodev.nvim](https://github.com/folke/neodev.nvim) with
  [lazydev.nvim](https://github.com/folke/lazydev.nvim)

## New key mappings

- None

# nvim-sq 1.4 - 21 April 2025

## Changes

- None

## New plugins

- [csvview.nvim](https://github.com/hat0uma/csvview.nvim)

## New key mappings

- `gr`->`gs` LSP \[g\]o to reference\[s\], since it conflicts with `gr`
  LSP-related key mappings starting with nvim 0.11. This functionality is now
  implemented by default starting with nvim 0.11 by the `grr` key mapping.

# nvim-sq 1.3 - 10 April 2025

## Changes

- Zig buffers can now be executed with `<leader>cx`
- Removed deprecated Neovim API

# nvim-sq 1.2 - 20 February 2025

## Changes

- Snippets for the [Catch2](https://github.com/catchorg/Catch2) unit testing
  framework

# nvim-sq 1.1 - 6 February 2025

## Changes

- Code refactoring
- Appends `/` when auto-completing paths in Command mode
- Rounded boxes for LSP hover/signature_help
- Toggle transparent background
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
- `<leader>br` to toggle transparent background, non-transparent by default

# nvim-sq 1.0 - 20 January 2025

- Initial public release
