return {
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  },


  {
    'Eandrju/cellular-automaton.nvim',
    config = function()
      vim.keymap.set('n', 'q:', '<cmd>CellularAutomaton make_it_rain<CR>')
    end
  },

  {
    "echasnovski/mini.align",
    opts = {
      mappings = {
        start_with_preview = 'ga',
      },
    },
  },
  {
    "echasnovski/mini.ai",
    opts = {},
    event = "VeryLazy",
  },
  {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
      vim.g.baleia = require("baleia").setup({})

      -- Command to colorize the current buffer
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        vim.g.baleia.once(vim.api.nvim_get_current_buf())
      end, { bang = true })

      -- Command to show logs
      vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
    end,
  },
  {
    'max397574/colortils.nvim',
    event = "VeryLazy",
    opts = {
      register = "0",
    },
  },
}
