-- Generic Lua functions

---@class CoreUtil
local M = {}

--- Merge 2 Lua tables into a new table
---@param table1 table?
---@param table2 table?
---@return table
function M.merge_tables(table1, table2)
   local merged_table = {}
   if table1 then
      for key, value in pairs(table1) do
         merged_table[key] = value
      end
   end
   if table2 then
      for key, value in pairs(table2) do
         merged_table[key] = value
      end
   end
   return merged_table
end

--- Define keymaps from a mode → key → {rhs, opts} table and apply extra options
---@param mode string|string[] Mode or list of modes passed to vim.keymap.set
---@alias KeymapEntry { [1]: string|function, [2]: table|nil }
---@param rhs table<string, KeymapEntry> Mapping table keyed by lhs
---@param additional_options table? Extra options merged into each mapping
local function map_keys_inner(mode, rhs, additional_options)
   for key, cmd in pairs(rhs) do
      local keymap = cmd[1]
      local options = cmd[2]
      local all_options = M.merge_tables(options, additional_options)
      vim.keymap.set(mode, key, keymap, all_options)
   end
end

--- Apply keymaps for each supported mode in a single keymap sub-table
---@param keymap_tbl table Mode-keyed table of mappings
---@param additional_options table? Extra options merged into each mapping
function M.map_keys(keymap_tbl, additional_options)
   local allowed_modes =
      { n = true, i = true, v = true, s = true, x = true, o = true, c = true }
   for mode, rhs in pairs(keymap_tbl) do
      -- Check if 'mode' is a table; if so, check if the first element is
      -- allowed
      -- If 'mode' is a string, check if it's in our allowed list
      local primary_mode = type(mode) == "table" and mode[1] or mode
      if allowed_modes[primary_mode] then
         map_keys_inner(mode, rhs, additional_options)
      end
   end
end

--- Apply keymaps for all non-plugin keymap sub-tables in a keymaps table
---@param tbl table Table containing multiple keymap sub-tables
---@param additional_options table? Extra options merged into each mapping
function M.map_all_keys(tbl, additional_options)
   for _, keymap_tbl in pairs(tbl) do
      -- Keymap tables that contain 'plugin = true' are skipped
      -- Keymaps are buffer-local/key-triggered and are performed in the plugin
      -- config file
      if keymap_tbl.plugin then
         goto continue
      end
      M.map_keys(keymap_tbl, additional_options)
      ::continue::
   end
end

--- Set Neovim options for multiple scopes like `o`, `bo`, `wo`, `opt`, etc.
---@param options table Options grouped by scope name
function M.set_options(options)
   for scope, settings in pairs(options) do
      for key, value in pairs(settings) do
         vim[scope][key] = value
      end
   end
end

--- Returns an on_attach callback that enables format-on-save for a buffer
---@param augroup integer|string Augroup id or name used for `BufWritePre` autocmds
---@return fun(client:table, bufnr:integer) LSP on_attach callback
function M.format_on_save(augroup)
   return function(client, bufnr)
      if client:supports_method("textDocument/formatting") then
         vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
         })
         vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
               local state = require("core.state")
               if vim.b.lsp_format_on_save_current_buffer == false then
                  return
               end
               if
                  vim.b.lsp_format_on_save_current_buffer == true
                  or state.lsp_format_on_save_enabled_at_startup
               then
                  -- Do not call this asynchronously!
                  vim.lsp.buf.format({ async = false, bufnr = bufnr })
               end
            end,
            desc = "LSP format on save",
         })
      end
   end
end

--- Close or delete the current buffer while preserving the window layout
function M.smart_bd()
   local DEBUG = false

   local buf_no = vim.api.nvim_get_current_buf()
   -- local buf_name = vim.api.nvim_buf_get_name(buf_no)

   local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = buf_no })
   local buf_bt = vim.api.nvim_get_option_value("buftype", { buf = buf_no })
   if DEBUG then
      vim.notify(
         string.format("filetype: [%s] | buftype: [%s]", buf_ft, buf_bt),
         vim.log.levels.DEBUG,
         { title = "core.util.smart_bd (DEBUG)" }
      )
   end

   local close_Cwc = 'execute "normal! \\<C-w>c"'
   local close_bd = 'execute ":bd!"'

   -- Special buffers
   -- Keys are tables of the form {buf_ft, [OPTIONAL buf_bt]}
   local buf_cmds = {
      [{ "chatgpt-input" }] = close_Cwc,
      [{ "diff" }] = close_Cwc,
      [{ "fugitive" }] = close_Cwc,
      [{ "fugitiveblame" }] = close_Cwc,
      [{ "git" }] = close_Cwc,
      [{ "gitsigns-blame" }] = close_Cwc,
      [{ "help" }] = close_Cwc,
      [{ "man" }] = close_Cwc,
      [{ "neo-tree" }] = close_Cwc,
      [{ "netrw" }] = close_Cwc,
      [{ "orgagenda" }] = close_Cwc,
      [{ "Outline" }] = close_Cwc,
      [{ "qf" }] = close_Cwc,
      [{ "query" }] = close_Cwc,
      [{ "trouble" }] = close_Cwc,
      [{ "undotree" }] = close_Cwc,

      [{ "markdown", "nofile" }] = close_Cwc,
      [{ "vim", "nofile" }] = close_Cwc,

      [{ "", "nofile" }] = close_bd,
      [{ "", "terminal" }] = close_bd,
   }
   for buf, cmd in pairs(buf_cmds) do
      local selected = (buf[1] == buf_ft)
         and ((not buf[2]) or (buf[2] == buf_bt))
      if selected then
         pcall(vim.api.nvim_command, cmd)
         return
      end
   end

   -- All other buffers
   local bd = require("bufdelete")
   bd.bufdelete()
end

--- Returns current local time as a `TimeOfDay` table
---@return TimeOfDay
function M.get_time()
   local t = os.date("*t") -- Get the current date and time as a table
   return { hour = t.hour, min = t.min }
end

--- Returns `true` when `t1` is less or equal to `t2`
---@param t1 TimeOfDay
---@param t2 TimeOfDay
---@return boolean
function M.time_is_less_than_or_equal(t1, t2)
   if t1.hour < t2.hour then
      return true
   elseif t1.hour == t2.hour then
      return t1.min <= t2.min
   else
      return false
   end
end

--- Returns `true` when `t1` is later than `t2`
---@param t1 TimeOfDay
---@param t2 TimeOfDay
---@return boolean
function M.time_is_greater_than(t1, t2)
   return not M.time_is_less_than_or_equal(t1, t2)
end

--- LSP diagnostic settings
---@type table
local diagnostic_signs = {
   [vim.diagnostic.severity.ERROR] = "",
   [vim.diagnostic.severity.WARN] = "",
   [vim.diagnostic.severity.INFO] = "",
   [vim.diagnostic.severity.HINT] = "󰌵",
}
M.diagnostic_signs = diagnostic_signs

-- LSP diagnostic short names
---@type table<string,string>
local shorter_source_names = {
   ["Lua Diagnostics."] = "Lua",
   ["Lua Syntax Check."] = "Lua",
}

--- Formats a diagnostic message for virtual text or virtual lines
---@param diagnostic table LSP diagnostic item
---@return string
function M.diagnostic_format(diagnostic)
   return string.format(
      "%s %s (%s): %s",
      diagnostic_signs[diagnostic.severity],
      shorter_source_names[diagnostic.source] or diagnostic.source,
      diagnostic.code,
      diagnostic.message
   )
end

--- Base diagnostic config that disables both virtual text and virtual lines.
--- Used as a reset before applying a specific diagnostic level preset.
---@type vim.diagnostic.Opts
local lsp_no_virtual_lines_text = {
   virtual_lines = false,
   virtual_text = false,
}

-- LSP diagnostic levels

--- LSP diagnostics level 0: disable virtual text and virtual lines
function M.lsp_diagnostics_level_0()
   vim.diagnostic.config(lsp_no_virtual_lines_text)
end

--- LSP diagnostics level 1: virtual text on the current line only.
--- No virtual lines. Underline and severity sorting enabled.
function M.lsp_diagnostics_level_1()
   vim.diagnostic.config(lsp_no_virtual_lines_text)
   local dl1 = {
      virtual_text = {
         current_line = true,
         spacing = 1,
         -- prefix = "",
         format = M.diagnostic_format,
      },
      -- signs = {
      --    text = diagnostic_signs,
      -- },
      underline = true,
      -- update_in_insert = true,
      severity_sort = true,
   }
   vim.diagnostic.config(dl1)
end

--- LSP diagnostics level 2: virtual lines on the current line only
function M.lsp_diagnostics_level_2()
   vim.diagnostic.config(lsp_no_virtual_lines_text)
   local dl2 = {
      virtual_lines = {
         current_line = true,
         format = M.diagnostic_format,
      },
      underline = true,
      severity_sort = true,
   }
   vim.diagnostic.config(dl2)
end

--- LSP diagnostics level 3: virtual text on all lines
function M.lsp_diagnostics_level_3()
   vim.diagnostic.config(lsp_no_virtual_lines_text)
   local dl3 = {
      virtual_text = {
         current_line = false,
         spacing = 1,
         -- prefix = "",
         format = M.diagnostic_format,
      },
      underline = true,
      severity_sort = true,
   }
   vim.diagnostic.config(dl3)
end

--- LSP diagnostics level 4: virtual lines on all lines.
function M.lsp_diagnostics_level_4()
   vim.diagnostic.config(lsp_no_virtual_lines_text)
   local dl4 = {
      virtual_lines = {
         current_line = false,
         format = M.diagnostic_format,
      },
      underline = true,
      severity_sort = true,
   }
   vim.diagnostic.config(dl4)
end

return M
