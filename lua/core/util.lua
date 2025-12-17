-- Generic Lua functions

local M = {}

-- Merge 2 Lua tables
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

-- Utility function for M.map_keys()
local function map_keys_inner(mode, rhs, additional_options)
   for key, cmd in pairs(rhs) do
      local keymap = cmd[1]
      local options = cmd[2]
      local all_options = M.merge_tables(options, additional_options)
      vim.keymap.set(mode, key, keymap, all_options)
   end
end

-- Map keys for single non-plugin sub-table
function M.map_keys(keymap_tbl, additional_options)
   local allowed_modes = { n = true, i = true, v = true, x = true, c = true }
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

-- Map keys for all sub-tables in the keymaps table
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

-- Set Neovim options
function M.set_options(options)
   for scope, settings in pairs(options) do
      for key, value in pairs(settings) do
         vim[scope][key] = value
      end
   end
end

-- Format on save
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

-- Delete current buffer, preserve splits
function M.smart_bd()
   local debug = false

   local buf_no = vim.api.nvim_get_current_buf()
   -- local buf_name = vim.api.nvim_buf_get_name(buf_no)

   local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = buf_no })
   local buf_bt = vim.api.nvim_get_option_value("buftype", { buf = buf_no })
   if debug then
      print(string.format("filetype: [%s] | buftype: [%s]", buf_ft, buf_bt))
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

-- Returns current time as a table {hh, mm}
function M.get_time()
   local t = os.date("*t") -- Get the current date and time as a table
   return { hour = t.hour, min = t.min }
end

-- Returns true when t1 <= t2, where t1 and t2 are time tables {hh, mm}
function M.time_is_less_than_or_equal(t1, t2)
   if t1.hour < t2.hour then
      return true
   elseif t1.hour == t2.hour then
      return t1.min <= t2.min
   else
      return false
   end
end

-- Returns true when t1 > t2, where t1 and t2 are time tables {hh, mm}
function M.time_is_greater_than(t1, t2)
   return not M.time_is_less_than_or_equal(t1, t2)
end

-- LSP diagnostic settings
local diagnostic_signs = {
   [vim.diagnostic.severity.ERROR] = "",
   [vim.diagnostic.severity.WARN] = "",
   [vim.diagnostic.severity.INFO] = "",
   [vim.diagnostic.severity.HINT] = "󰌵",
}
M.diagnostic_signs = diagnostic_signs

-- LSP diagnostic short names
local shorter_source_names = {
   ["Lua Diagnostics."] = "Lua",
   ["Lua Syntax Check."] = "Lua",
}

-- LSP diagnostic format
function M.diagnostic_format(diagnostic)
   return string.format(
      "%s %s (%s): %s",
      diagnostic_signs[diagnostic.severity],
      shorter_source_names[diagnostic.source] or diagnostic.source,
      diagnostic.code,
      diagnostic.message
   )
end

local lsp_no_virtual_lines_text = {
   virtual_lines = false,
   virtual_text = false,
}

-- LSP diagnostic levels
function M.lsp_diagnostics_level_0()
   vim.diagnostic.config(lsp_no_virtual_lines_text)
end

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
