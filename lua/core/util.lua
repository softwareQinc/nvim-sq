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
   for mode, rhs in pairs(keymap_tbl) do
      -- Table as keys
      if type(mode) == "table" then
         for _, mode_elem in ipairs(mode) do
            map_keys_inner(mode_elem, rhs, additional_options)
         end
      else
         -- Regular keys
         if mode ~= "n" and mode ~= "i" and mode ~= "v" then
            goto continue
         end
         map_keys_inner(mode, rhs, additional_options)
      end
      ::continue::
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
               if state.lsp_format_on_save_enabled_at_startup then
                  -- Do not call this asynchronously!
                  vim.lsp.buf.format({ bufnr = bufnr })
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
      [{ "Outline" }] = close_Cwc,
      [{ "orgagenda" }] = close_Cwc,
      [{ "qf" }] = close_Cwc,
      [{ "query" }] = close_Cwc,
      [{ "trouble" }] = close_Cwc,
      [{ "undotree" }] = close_Cwc,
      [{ "vim" }] = close_Cwc,

      [{ "markdown", "nofile" }] = close_Cwc,
      [{ "", "nofile" }] = close_Cwc,
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

return M
