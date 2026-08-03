-- Use OpenTofu instead of Terraform with the LazyVim terraform extra enabled.
-- Keeps treesitter / telescope bits from the extra; swaps LSP, fmt, and validate.
--
-- Important: tofu-ls logs very verbosely to stderr by default. Neovim records all
-- LSP server stderr into lsp.log as [ERROR] rpc. Without -log-file, that alone
-- can grow lsp.log to gigabytes. See: tofu-ls serve -log-file …

local function tofu_ls_log_file()
  -- Dedicated file (not nvim's lsp.log). Truncate/delete freely if it grows.
  return vim.fs.joinpath(vim.fn.stdpath("log"), "tofu-ls.log")
end

--- Walk up from the current buffer looking for a module with local state/providers.
local function tofu_root_dir()
  local buf = vim.api.nvim_buf_get_name(0)
  if buf == "" then
    return vim.uv.cwd()
  end
  local path = vim.fs.dirname(buf)
  local found = vim.fs.find(".terraform", {
    upward = true,
    path = path,
    type = "directory",
  })[1]
  if found then
    return vim.fs.dirname(found)
  end
  -- Prefer workspace root over the file's directory (modules often lack .terraform).
  return vim.fs.root(0, { ".git", ".terraform" }) or path
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- LazyVim terraform extra enables this; we use tofu-ls instead.
        terraformls = { enabled = false },
        -- tflint is installed by the extra; if mason auto-enables it as an LSP
        -- client it also spams stderr into lsp.log. Prefer nvim-lint/CLI if needed.
        tflint = { enabled = false },

        tofu_ls = {
          -- Divert server logs off stderr so they never hit nvim's lsp.log.
          cmd = { "tofu-ls", "serve", "-log-file", tofu_ls_log_file() },

          -- Match lspconfig defaults + OpenTofu IDs.
          filetypes = { "opentofu", "opentofu-vars", "terraform", "terraform-vars" },
          root_markers = { ".terraform", ".git" },

          -- Static settings go via initialize (init_options). See:
          -- https://github.com/opentofu/tofu-ls/blob/main/docs/SETTINGS.md
          init_options = {
            -- Only override binary path when we actually find one; empty path is worse
            -- than letting the server search $PATH (which includes mason bin when nvim runs).
            tofu = vim.tbl_extend("keep", {}, (function()
              local p = vim.fn.exepath("tofu")
              return (p ~= "" and { path = p }) or {}
            end)()),

            -- Avoid noisy single-file workspace warnings when opening one .tf.
            ignoreSingleFileWarning = true,

            indexing = {
              -- Extra directory basenames to skip while indexing.
              -- Do NOT list names tofu-ls already reserves or forbids — e.g.
              -- ".terraform" makes initialize fail with:
              --   cannot ignore directory ".terraform"
              -- Always-ignored by the server (no need to repeat): .git, .idea,
              -- .vscode, terraform.tfstate.d, .terragrunt-cache.
              ignoreDirectoryNames = {
                "node_modules",
                ".direnv",
                "vendor",
              },
            },

            -- Enhanced validation is static (default true). Full `tofu validate`
            -- is left to nvim-lint below so we do not run both on every save via LS.
            experimentalFeatures = {
              validateOnSave = false,
            },
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
        ["opentofu-vars"] = { "tofu_fmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Builtin `tofu` linter uses the file's directory as -chdir, which fails for
      -- shared modules. Resolve the nearest initialized root (or git root) instead.
      local base = require("lint.linters.tofu")

      opts.linters = opts.linters or {}
      opts.linters.tofu_root = function()
        local linter = base()
        linter.args = { "-chdir=" .. tofu_root_dir(), "validate", "-json" }
        return linter
      end

      -- Replace LazyVim's terraform_validate with OpenTofu; do not stack both.
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
