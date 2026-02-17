-- Neovide-related generic Lua functions

---@class NeovideUtil
local M = {}

--- Adjust Neovide UI scale factor by `amount`.
--- Prevents scaling below 0.5.
---@param amount number Delta to add to `vim.g.neovide_scale_factor`
function M.neovide_scale(amount)
   local temp = vim.g.neovide_scale_factor + amount
   if temp < 0.5 then
      return
   end
   vim.g.neovide_scale_factor = temp
end

return M
