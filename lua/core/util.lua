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
      if v.plugin and v.plugin == true then
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
   local cur_buf_no = vim.api.nvim_get_current_buf()
   -- local cur_buf_name = vim.api.nvim_buf_get_name(cur_buf_no)

   -- Special filetype buffers
   local buffer_ft = vim.api.nvim_buf_get_option(cur_buf_no, "filetype")
   local close_buf_ft_cmd = 'execute "normal! \\<C-w>c"'
   local buffer_ft_cmd = {
      ["neo-tree"] = close_buf_ft_cmd,
      ["netrw"] = close_buf_ft_cmd,
      ["qf"] = close_buf_ft_cmd,
      ["query"] = close_buf_ft_cmd,
      ["Outline"] = close_buf_ft_cmd,
      ["Trouble"] = close_buf_ft_cmd,
   }
   for buf_ft, cmd in pairs(buffer_ft_cmd) do
      if buffer_ft == buf_ft then
         pcall(vim.api.nvim_command, cmd)
         return
      end
   end

   -- Special buftype buffers
   local buffer_bt = vim.api.nvim_buf_get_option(cur_buf_no, "buftype")
   local close_buf_bt_cmd = 'execute ":bd!"'
   local buffer_bt_cmd = {
      ["terminal"] = close_buf_bt_cmd,
   }
   for buf_bt, cmd in pairs(buffer_bt_cmd) do
      if buffer_bt == buf_bt then
         pcall(vim.api.nvim_command, cmd)
         return
      end
   end

   -- All other buffers
   local bd = require("bufdelete")
   bd.bufdelete()
end

return M
