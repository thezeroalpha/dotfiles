return {
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
    "nvim-mini/mini.align",
    opts = {
      mappings = {
        start_with_preview = 'ga',
      },
    },
  },
  {
    "nvim-mini/mini.ai",
    opts = {},
    event = "VeryLazy",
  },
  {
    "nvim-mini/mini.surround",
    config = function()
      -- Mappings similar to tpope/vim-surround
      require('mini.surround').setup({
        mappings = {
          add = 'ys',
          delete = 'ds',
          find = '',
          find_left = '',
          highlight = '',
          replace = 'cs',
        }
      })

      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del('x', 'ys')
      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

      -- Make special mapping for "add surrounding for line"
      vim.keymap.set('n', 'yss', 'ys_', { remap = true })
    end,
    event = "VeryLazy",
  },
  { "nvim-mini/mini.operators", opts = {} },
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
