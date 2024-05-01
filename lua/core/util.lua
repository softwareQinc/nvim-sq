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

-- Map keys for single non-plugin sub-table
function M.map_keys(tbl, additional_options)
   for mode, key_keymaps in pairs(tbl) do
      if mode ~= "n" and mode ~= "i" and mode ~= "v" then
         goto continue
      end
      for key, cmd in pairs(key_keymaps) do
         local keymap = cmd[1]
         local options = cmd[2]
         local all_options = M.merge_tables(options, additional_options)
         vim.keymap.set(mode, key, keymap, all_options)
      end
      ::continue::
   end
end

-- Map keys for all sub-tables in the keymaps table
function M.map_all_keys(tbl, additional_options)
   for _, v in pairs(tbl) do
      -- Keymap tables that contain 'plugin = true' are skipped
      -- Keymaps are buffer-local/key-triggered and are performed in the plugin
      -- config file
      if v.plugin and v.plugin then
         goto continue
      end
      M.map_keys(v, additional_options)
      ::continue::
   end
end

-- Set Vim options
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
      if client.supports_method("textDocument/formatting") then
         vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
         })
         vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
               vim.lsp.buf.format({ bufnr = bufnr })
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
   local buf_name = vim.api.nvim_buf_get_name(buf_no)

   local buf_ft = vim.api.nvim_buf_get_option(buf_no, "filetype")
   local buf_bt = vim.api.nvim_buf_get_option(buf_no, "buftype")
   if debug then
      print(string.format("filetype: [%s] | buftype: [%s]", buf_ft, buf_bt))
   end

   local close_Cwc = 'execute "normal! \\<C-w>c"'
   local close_bd = 'execute ":bd!"'

   -- Special buffers
   -- Keys are tables of the form {buf_ft, [OPTIONAL buf_bt]}
   local buf_cmds = {
      [{ "fugitiveblame" }] = close_Cwc,
      [{ "help" }] = close_Cwc,
      [{ "man" }] = close_Cwc,
      [{ "neo-tree" }] = close_Cwc,
      [{ "netrw" }] = close_Cwc,
      [{ "Outline" }] = close_Cwc,
      [{ "qf" }] = close_Cwc,
      [{ "query" }] = close_Cwc,
      [{ "Trouble" }] = close_Cwc,
      [{ "vim" }] = close_Cwc,

      [{ "", "nofile" }] = close_Cwc,
      [{ "", "terminal" }] = close_bd,
      [{ "git", "nowrite" }] = close_Cwc,
   }
   for buf, cmd in pairs(buf_cmds) do
      local selected = (buf[1] == buf_ft) and ((not buf[2]) or (buf[2] == buf_bt))
      if selected then
         pcall(vim.api.nvim_command, cmd)
         return
      end
   end

   -- All other buffers
   local bd = require("bufdelete")
   bd.bufdelete()
end

return M
