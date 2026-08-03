-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>uH", function()
  require("lsp-endhints").toggle()
end, { desc = "Toggle Inlay Hints (end-of-line)" })

vim.keymap.set({ "n", "x" }, "<leader>ue", function()
  local expand = not vim.bo.expandtab
  vim.bo.expandtab = expand

  local cmd = "retab! -indentonly"
  if vim.fn.mode():find("[vV\22]") then
    vim.cmd("'<,'>" .. cmd)
  else
    vim.cmd("%" .. cmd)
  end

  vim.notify(("Indent: %s (tabstop=%d)"):format(expand and "spaces" or "tabs", vim.bo.tabstop), vim.log.levels.INFO)
end, { desc = "Toggle Tabs/Spaces Indenting" })
