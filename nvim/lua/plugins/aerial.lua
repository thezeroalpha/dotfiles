-- Code outline
return {
  'stevearc/aerial.nvim',
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
    filter_kind = false,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  keys = {
    { "<leader>tt", "<cmd>AerialToggle!<cr>", desc = "Toggle tagbar" },
    { "<leader>to", "<cmd>AerialOpen<cr>",    desc = "Open and jump to tagbar" },
  },
}
