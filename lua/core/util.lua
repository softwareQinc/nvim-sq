-- Generic Lua functions

---@class CoreUtil
local M = {}

--- Define keymaps from a mode → key → {rhs, opts} table and apply extra options
---@param mode string|string[] Mode or list of modes passed to vim.keymap.set
---@alias KeymapEntry { [1]: string|function, [2]: table|nil }
---@param rhs table<string, KeymapEntry> Mapping table keyed by lhs
---@param default_opts table? Default keymap options applied to all mappings (overridden by per-keymap options)
local function map_keys_inner(mode, rhs, default_opts)
   for key, cmd in pairs(rhs) do
      local keymap = cmd[1]
      local options = cmd[2]

      -- Merge global defaults with per-keymap options
      -- Later tables override earlier ones:
      --   options > default_opts
      local all_options = vim.tbl_extend(
         "force",
         default_opts or {}, -- global defaults
         options or {} -- per-keymap, takes precendence
      )
      vim.keymap.set(mode, key, keymap, all_options)
   end
end

--- Apply keymaps for each supported mode in a single keymap sub-table
---@param keymap_tbl table Mode-keyed table of mappings
---@param default_opts table? Default keymap options applied to all mappings (overridden by per-keymap options)
function M.map_keys(keymap_tbl, default_opts)
   local allowed_modes =
      { n = true, i = true, v = true, s = true, x = true, o = true, c = true }
   for mode, rhs in pairs(keymap_tbl) do
      -- Check if `mode` is a table; if so, check if the first element is
      -- allowed
      -- If `mode` is a string, check if it's in our allowed list
      local primary_mode = type(mode) == "table" and mode[1] or mode
      if allowed_modes[primary_mode] then
         map_keys_inner(mode, rhs, default_opts)
      end
   end
end

--- Apply keymaps for all non-plugin keymap sub-tables in a keymaps table
---@param tbl table Table containing multiple keymap sub-tables
---@param default_opts table? Default keymap options applied to all mappings (overridden by per-keymap options)
function M.map_all_keys(tbl, default_opts)
   for _, keymap_tbl in pairs(tbl) do
      -- Keymap tables that contain `plugin = true` are skipped
      -- Keymaps are buffer-local/key-triggered and are performed in the plugin
      -- config file
      if keymap_tbl.plugin then
         goto continue
      end
      M.map_keys(keymap_tbl, default_opts)
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

--- Close or delete the current buffer while preserving the window layout
function M.smart_bd()
   local DEBUG = false

   local buf_no = vim.api.nvim_get_current_buf()
   -- local buf_name = vim.api.nvim_buf_get_name(buf_no)

   local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = buf_no })
   local buf_bt = vim.api.nvim_get_option_value("buftype", { buf = buf_no })
   if DEBUG then
      vim.notify(
         ("filetype: [%s] | buftype: [%s]"):format(buf_ft, buf_bt),
         vim.log.levels.DEBUG,
         { title = "core.util.smart_bd (DEBUG)" }
      )
   end

   local close_Cwc = 'execute "normal! \\<C-w>c"'
   local close_bd = 'execute ":bd!"'

   -- Special buffers
   -- Keys are tables of the form {buf_ft, [OPTIONAL buf_bt]}
   local buf_cmds = {
      [{ "Outline" }] = close_Cwc,
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
      [{ "nvim-undotree" }] = close_Cwc,
      [{ "orgagenda" }] = close_Cwc,
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
   return ("%s %s (%s): %s"):format(
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

--- Expand, normalize, and optionally resolve a filesystem path.
--- Returns the real path if it exists, otherwise the normalized path
--- unless `opts.strict` is true (then returns nil).
---@param path string
---@param opts? { strict?: boolean }  -- strict=true: return nil if path doesn't exist
---@return string|nil
function M.resolve_path(path, opts)
   opts = opts or {}
   -- Expand (~, env vars)
   local expanded = vim.fn.expand(path)
   -- Normalize (clean up path)
   local normalized = vim.fs.normalize(expanded)
   -- Try to resolve to real path (requires existence)
   local real = vim.uv.fs_realpath(normalized)
   if real then
      return real
   end
   -- If strict, fail when path doesn't exist
   if opts.strict then
      return nil
   end
   -- Otherwise return best-effort normalized path
   return normalized
end

--- Returns LSP server names discovered from configuration directories
---
--- Scans the provided directories for `*.lua` files, derives the server name
--- from each file name, de-duplicates them, and returns a sorted list.
---
---@param dirs? string[] List of directories to scan
---  Defaults to:
---    - stdpath("config") .. "/lsp"
---    - stdpath("config") .. "/after/lsp"
--- @return string[] Sorted list of LSP server names
function M.get_lsp_server_names(dirs)
   local servers = {}

   if dirs ~= nil and type(dirs) ~= "table" then
      vim.notify(
         "get_lsp_server_names(): dirs must be a list",
         vim.log.levels.ERROR
      )
      return {}
   end

   dirs = dirs
      or {
         vim.fn.stdpath("config") .. "/lsp",
         vim.fn.stdpath("config") .. "/after/lsp",
      }

   for _, dir in ipairs(dirs) do
      local lsp_dir = vim.fn.fnamemodify(dir, ":p")

      for _, file in ipairs(vim.fn.globpath(lsp_dir, "*.lua", false, true)) do
         local server = vim.fn.fnamemodify(file, ":t:r")
         servers[server] = true
      end
   end

   local results = vim.tbl_keys(servers)
   table.sort(results)
   return results
end

return M
