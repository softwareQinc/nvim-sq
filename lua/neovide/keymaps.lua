-- Neovide keymaps

---@class NeovideKeymaps
local M = {}

------------------------------------------------------------------------------
-- Scale fonts up and down with <Command>= and <Command>-, respectively
local increment = 0.1
local decrement = -increment
local cmd_font_increase = ":lua require('neovide.util').neovide_scale("
   .. increment
   .. ")<CR>"
local cmd_font_decrease = ":lua require('neovide.util').neovide_scale("
   .. decrement
   .. ")<CR>"
M.scale = {
   n = {
      ["<D-=>"] = {
         cmd_font_increase,
         { desc = "Increase font size" },
      },
      ["<D-->"] = {
         cmd_font_decrease,
         { desc = "Decrease font size" },
      },
   },
   i = {
      ["<D-=>"] = {
         "<C-o>" .. cmd_font_increase,
         { desc = "Increase font size" },
      },
      ["<D-->"] = {
         "<C-o>" .. cmd_font_decrease,
         { desc = "Decrease font size" },
      },
   },
   v = {
      ["<D-=>"] = {
         "<ESC>" .. cmd_font_increase .. "gv",
         { desc = "Increase font size" },
      },
      ["<D-->"] = {
         "<ESC>" .. cmd_font_decrease .. "gv",
         { desc = "Decrease font size" },
      },
   },
}

M.background_transparency = {
   n = {
      ["<leader>br"] = {
         function()
            local count = vim.v.count

            -- Remember last count-derived opacity (default 50%)
            vim.g._last_neovide_opacity_from_count = vim.g._last_neovide_opacity_from_count
               or 0.5

            -- NO COUNT -> toggle
            if count == 0 then
               if vim.g.neovide_opacity == 1 then
                  vim.g.neovide_opacity = vim.g._last_neovide_opacity_from_count
               else
                  vim.g.neovide_opacity = 1
               end
            else
               -- WITH COUNT -> set + remember
               if count < 0 then
                  count = 0
               end
               if count > 100 then
                  count = 100
               end

               local opacity = 1 - (count / 100)
               vim.g.neovide_opacity = opacity
               vim.g._last_neovide_opacity_from_count = opacity
            end

            -- ---- MESSAGE ----
            local opacity = vim.g.neovide_opacity or 1
            local transparency_pct = math.floor((1 - opacity) * 100 + 0.5)

            vim.notify(
               string.format("Transparent background: %d%%", transparency_pct),
               vim.log.levels.INFO,
               { title = "neovide.keymaps.background_transparency" }
            )
         end,
         {
            desc = "Toggle [b]ackground t[r]ansparency or set via count (1-100)",
         },
      },
   },
}

return M
