------------------------------------------------------------------------------
-- Neovide additional initialization, executed only by a Neovide session,
-- after all other initialization is performed

local util = require("core.util")

------------------------------------------------------------------------------
-- Neovide additional options
local options = require("neovide.options")
util.set_options(options)

------------------------------------------------------------------------------
-- Scale fonts up/down with `<Command> =` and `<Command> -`, respectively
local keymaps = require("neovide.keymaps")
util.map_all_keys(keymaps, { noremap = true, silent = true })

------------------------------------------------------------------------------
-- Set custom font.
-- Should be set in `$XDG_CONFIG_HOME/neovide/config.toml`, see
-- https://neovide.dev/config-file.html#font
-- Alternatively, use, e.g.,
-- vim.cmd.set("guifont=JetBrainsMono\\ Nerd\\ Font:h16")

------------------------------------------------------------------------------
-- Enable copy/paste shortcuts on Mac, expect to be fixed in future versions
-- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
vim.keymap.set("v", "<D-c>", '"+y') -- Copy
vim.keymap.set("n", "<D-v>", '"+P') -- Paste Normal mode
vim.keymap.set("v", "<D-v>", '"+P') -- Paste Visual mode
vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste Command mode
vim.keymap.set("i", "<D-v>", "<C-R>+") -- Paste Insert mode
