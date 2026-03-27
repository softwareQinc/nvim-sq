-- Rust
---@type vim.lsp.Config
return {
   filetypes = { "rust" },
   root_markers = { "Cargo.toml" },
   settings = {
      ["rust-analyzer"] = {
         cargo = { allFeatures = true },
      },
   },
}
