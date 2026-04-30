-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.listchars = "tab:  ⇀,space:·"
vim.opt.expandtab = false

-- vim.g.lazyvim_php_lsp = "intelephense"

vim.opt.mousescroll = "ver:2,hor:4"

-- enable per-project settings
vim.opt.exrc = true
vim.opt.secure = true

-- workaround for bug https://github.com/LazyVim/LazyVim/issues/6979
vim.g.omni_sql_no_default_maps = true
