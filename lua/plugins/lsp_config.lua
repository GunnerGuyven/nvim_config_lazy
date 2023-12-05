return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        lua_ls = {
          Lua = {
            hint = { enable = true },
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
}
