local M = {}

M.neovide_scale = function(amount)
   local temp = vim.g.neovide_scale_factor + amount
   if temp < 0.5 then
      return
   end
   vim.g.neovide_scale_factor = temp
end

return M
