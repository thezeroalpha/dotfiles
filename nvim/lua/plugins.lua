return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {'williamboman/mason.nvim',
        opts = {},
      },
      { 'williamboman/mason-lspconfig.nvim',
        config = function()
          require 'config.mason-lspconfig'
        end,
      },

      -- Useful status updates for LSP
      {'j-hui/fidget.nvim',
        opts = {},
      },

      -- Additional lua configuration, makes nvim stuff amazing
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { "nvim-dap-ui" }, types = true },
        },
      }
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup { sources = { null_ls.builtins.code_actions.shellcheck, null_ls.builtins.diagnostics.checkmake } }
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    config = function()
      require 'config.nvim-cmp'
    end,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require 'config.nvim-treesitter'
    end,
  },

  -- Additional text objects via treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function()
        vim.keymap.set('n', ']c', function() require('gitsigns').next_hunk() end, {buffer = true})
        vim.keymap.set('n', '[c', function() require('gitsigns').prev_hunk() end, {buffer = true})
        vim.keymap.set('n', ']=', function() require('gitsigns').preview_hunk_inline() end, {buffer = true})
        vim.keymap.set('n', ']+', function() require('gitsigns').select_hunk() end, {buffer = true})
      end,
    },
  },


  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
      filetype = {'python'},
    }
  },

  {
    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
    opts = {}
  },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'config.telescope'
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable 'make' == 1
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  },

  -- DAP: debugging
  { 'mfussenegger/nvim-dap', config = function()
    require 'config.nvim-dap'
  end
  },
  {'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
    end
  },
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}, config = function()
      require 'config.nvim-dap-ui'
  end
  },

  {'theHamsta/nvim-dap-virtual-text', dependencies = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"}, config = function()
    require("nvim-dap-virtual-text").setup()
  end},

  { 'lvimuser/lsp-inlayhints.nvim', config = function()
    require 'config.lsp-inlayhints'
  end},

  { 'Eandrju/cellular-automaton.nvim', config = function()
    vim.keymap.set('n', 'q:', '<cmd>CellularAutomaton make_it_rain<CR>')
  end},

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader><leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<leader>S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  -- {
  --   "chrisgrieser/nvim-origami",
  --   event = "BufReadPost", -- later or on keypress would prevent saving folds
  --   opts = true, -- needed even when using default config
  --   config = function()
  --     require('origami').setup({
  --       pauseFoldsOnSearch = true,
  --     })
  --   end
  -- },
  --
}
