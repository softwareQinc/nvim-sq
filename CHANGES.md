# nvim-sq 1.16 - 19 February 2026

## Changes

- LuaLS type annotations and improved inline documentation

## New plugins

- None

## Removed plugins

- None

## New key mappings

- `[count] <leader>br` (Neovide only) - Toggle background transparency, or sets
  background transparency via count (1-100)

---

# nvim-sq 1.15 - 15 February 2026

## Changes

- Minor UI tweaks and Mason plugin URL fixes

## New plugins

- None

## Removed plugins

- [luarocks.nvim](https://github.com/vhyrro/luarocks.nvim), no longer required
  by [neorg](https://github.com/nvim-neorg/neorg)

## New key mappings

- `<leader>iH` - Toggle inlay hints for the current buffer (sticky; overrides
  the global setting set by `<leader>ih`)

---

# nvim-sq 1.14 - 8 January 2026

## Changes

- Added
  [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server)
  and [ESLint](https://eslint.org/) (pre-installed with native support for both
  JavaScript and TypeScript)
- Removed [hls](https://github.com/haskell/haskell-language-server), as
  [haskell-tools](https://github.com/mrcjkb/haskell-tools.nvim) already
  provides the required functionality
- Minor UI fixes

## New plugins

- [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)

## Removed plugins

- None

## New key mappings

- `[^` - Tree-sitter jump to parent context (repeatable with count)

---

# nvim-sq 1.13 - 21 December 2025

## Changes

- Added [Tombi](https://github.com/tombi-toml/tombi), a TOML language server
  (pre-installed)
- Added [YAML Language Server](https://github.com/redhat-developer/yaml-language-server)
  (pre-installed)

## New plugins

- None

## Removed plugins

- None

## New key mappings

- `<leader>fm` in Visual Mode - formats Visual selections through LSP, provided
  the language server supports range formatting

---

# nvim-sq 1.12 - 8 December 2025

## Changes

- [basedpyright](https://github.com/DetachHead/basedpyright) now replaces
  [pyright](https://github.com/microsoft/pyright) as the default Python LSP
- Updated CMake Lua snippets
- Restore last cursor position and centre the screen when reopening a file
- Background transparency toggle now shows its current status
- Canadian English spelling by default

## New plugins

- [nvim-colorizer](https://github.com/catgoose/nvim-colorizer.lua) (fork),
  replaces the original plugin (see below)

## Removed plugins

- [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua), no
  longer actively maintained

## New key mappings

- None

---

# nvim-sq 1.11 - 24 September 2025

## Changes

- `julials` uses now the new Neovim 0.11 LSP config style, eliminating obsolete
  warnings

## New plugins

- None

## Removed plugins

- None

## New key mappings

- None

---

# nvim-sq 1.10 - 3 September 2025

## Changes

- Telescope now uses latest commit instead of the release 0.1.8 due to
  deprecation bug fixes
- Built-in terminal now uses the default `vim.o.shell` instead of `bash`
- Aesthetic improvements to LSP inline diagnostic display
- Executing `<leader>cx` in C/C++ buffers now supports an optional COUNT to set
  the language standard. For example, `23<leader>cx` selects C++23 in a `cpp`
  buffer, while `11<leader>cx` selects C11 in a `c` buffer.
- Bug fix in executing C/C++ buffers with `<leader>cx`
- Python buffers can now be executed with `<leader>cx`

## New plugins

- None

## Removed plugins

- None

## New key mappings

- None

---

# nvim-sq 1.9 - 4 August 2025

## Changes

- Updated documentation, added note about `curl` being required
- Lualine displays `!EOL` when a file does not have EOL (End Of Line)

## New plugins

- None

## Removed plugins

- None

## New key mappings

- `<leader>tc` - `:TSContext toggle` (`nvim-treesitter-context`), toggle
  Tree-sitter code context, ON by default

---

# nvim-sq 1.8 - 24 June 2025

## Changes

- None

## New plugins

- None

## Removed plugins

- None

## New key mappings

- `<leader>foS` - Toggle LSP auto-formatting on save on **current buffer**,
  has higher priority than LSP auto-formatting on save on all buffers
  (`<leader>fos`). So if you toggle, e.g., LSP auto-formatting on current
  buffer to `false`, you need to toggle it again to re-enable it, regardless of
  the state of LSP auto-formatting on save on all buffers.

  To disable LSP auto-formatting for a specific file type (e.g., Markdown), add
  the following line to `after/ftplugin/markdown.lua`

  ```lua
  vim.b.lsp_format_on_save_current_buffer = false
  ```

  Replace `markdown.lua`
  with the appropriate file type for which you want to disable auto-formatting
  on save.

---

# nvim-sq 1.7 - 14 June 2025

## Changes

- LSP diagnostics messages using virtual lines/text

## New plugins

- None

## Removed plugins

- None

## New key mappings

- `<leader>dl0` - No LSP virtual lines/text diagnostics (default)
- `<leader>dl1` - LSP diagnostics, level 1
- `<leader>dl2` - LSP diagnostics, level 2
- `<leader>dl3` - LSP diagnostics, level 3
- `<leader>dl4` - LSP diagnostics, level 4
- `<leader>dlt` - LSP diagnostics, toggle ON/OFF the current diagnostic level

---

# nvim-sq 1.6 - 3 June 2025

## Changes

- Migrated to the new LSP configuration format. Requires Neovim 0.11 or later.
- Removed deprecated API
- Minor bug fixes

## New plugins

- None

## New key mappings

- None

---

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

---

# nvim-sq 1.4 - 21 April 2025

## Changes

- None

## New plugins

- [csvview.nvim](https://github.com/hat0uma/csvview.nvim)

## New key mappings

- `gr`->`gs` LSP \[g\]o to reference\[s\], since it conflicts with `gr`
  LSP-related key mappings starting with nvim 0.11. This functionality is now
  implemented by default starting with nvim 0.11 by the `grr` key mapping.

---

# nvim-sq 1.3 - 10 April 2025

## Changes

- Zig buffers can now be executed with `<leader>cx`
- Removed deprecated Neovim API

---

# nvim-sq 1.2 - 20 February 2025

## Changes

- Snippets for the [Catch2](https://github.com/catchorg/Catch2) unit testing
  framework

# nvim-sq 1.1 - 6 February 2025

---

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

---

# nvim-sq 1.0 - 20 January 2025

- Initial public release
