-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>uH", function()
  require("lsp-endhints").toggle()
end, { desc = "Toggle Inlay Hints (end-of-line)" })
