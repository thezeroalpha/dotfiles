return {
  {
    'stevearc/dressing.nvim',
    opts = {},
  },



  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '┊',
      },
    }
  },

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
    "echasnovski/mini.animate",
    config = function()
      local animate = require('mini.animate')
      animate.setup({
        cursor = {
          enable = false,
        },
        scroll = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 50, unit = 'total' }),
        },
        resize = {
          enable = false,
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
      })
    end,
    version = false,
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
    'sphamba/smear-cursor.nvim',
    opts = {
      cursor_color = '#a4a4a4',
      legacy_computing_symbols_support = true,
      stiffness = 0.8,               -- 0.6      [0, 1]
      trailing_stiffness = 0.5,      -- 0.3      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
    },
  },
  {
    'max397574/colortils.nvim',
    event = "VeryLazy",
    opts = {
      register = "0",
    },
  },
}
