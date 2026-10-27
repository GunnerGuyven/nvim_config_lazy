return {
  {
    "nvim-neorg/neorg",
    lazy = false, -- docs recommend immediate load
    version = "*",
    -- These rocks build the parsers. Declaring them as dependencies makes
    -- lazy put their lib/lua/5.1 paths on package.cpath before Neorg's config.
    dependencies = {
      "nvim-neorg/tree-sitter-norg",
      "nvim-neorg/tree-sitter-norg-meta",
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<localleader>t", group = "tasks" },
        { "<localleader>l", group = "lists" },
        { "<localleader>n", group = "notes" },
        { "<localleader>i", group = "insert" },
        { "<localleader>c", group = "code" },
      },
    },
  },
}
