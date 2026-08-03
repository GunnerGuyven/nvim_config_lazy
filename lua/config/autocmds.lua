-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- autocmd BufRead,BufNewFile dockerfile.* set filetype=dockerfile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "dockerfile.*",
  command = "setfiletype dockerfile",
})

-- Markdown: spaces by default (tabs disturb linter)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
