-- Use OpenTofu instead of Terraform with the LazyVim terraform extra enabled.
-- Keeps treesitter/tflint/telescope from the extra; swaps LSP, fmt, and validate.

local function tofu_root_dir()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
  while path ~= "/" and path ~= "" do
    if vim.fn.isdirectory(path .. "/.terraform") == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.:h")
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = { enabled = false },
        tofu_ls = {
          init_options = {
            tofu = {
              path = vim.fn.exepath("tofu"),
            },
            -- Avoid validating module folders in isolation (no local .terraform).
            -- experimentalFeatures = {
            --   validateOnSave = false,
            -- },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "tofu_fmt" },
        tf = { "tofu_fmt" },
        ["terraform-vars"] = { "tofu_fmt" },
        opentofu = { "tofu_fmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local base = require("lint.linters.tofu")

      opts.linters = opts.linters or {}
      opts.linters.tofu_root = function()
        local linter = base()
        linter.args = { "-chdir=" .. tofu_root_dir(), "validate", "-json" }
        return linter
      end

      opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft or {}, {
        terraform = { "tofu_root" },
        tf = { "tofu_root" },
        opentofu = { "tofu_root" },
      })

      return opts
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "tofu-ls" },
    },
  },
}

