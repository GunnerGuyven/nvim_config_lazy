return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --  codelens = { enabled = true },
      inlay_hints = { enabled = true },
      update_in_insert = true,
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = { enable = true },
            },
          },
        },
        clangd = {},
        zls = {},
        ols = {},
        lemminx = {},
        -- phpactor = {},
        denols = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                -- variableTypes = {
                --   enabled = true,
                --   suppressWhenTypeMatchesName = true,
                -- },
              },
            },
            javascript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = true,
                },
              },
            },
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  "[cC]lass\\w*\\s*(?:=|:)\\s*`([^`]*)`",
                  "[cC]lass\\w*\\s*(?:=|:)\\s*'([^']*)'",
                  '[cC]lass\\w*\\s*(?:=|:)\\s*"([^"]*)"',
                },
              },
            },
          },
        },
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = true,
                },
              },
            },
            javascript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = true,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "cpp",
        "odin",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      formatters = {
        php_cs_fixer = {
          cwd = require("conform.util").root_file({ ".php-cs-fixer.dist.php" }),
          env = {
            PHP_CS_FIXER_IGNORE_ENV = 1,
          },
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      scope = {
        cursor = false,
      },
      -- indent = {
      --   scope = {
      --     underline = true,
      --   },
      -- },
    },
  },
}
