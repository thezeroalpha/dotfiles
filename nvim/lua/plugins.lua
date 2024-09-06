return {
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        opts = {},
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          require 'config.mason-lspconfig'
        end,
      },

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
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
      null_ls.setup { sources = {
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.phpcs,
        -- null_ls.builtins.diagnostics.vacuum,
        null_ls.builtins.diagnostics.yamllint.with({
          extra_args = {
            "-d", [[{
              extends: default,
              rules: {
                line-length: {max: 160},
                document-start: disable,
                comments: {
                  min-spaces-from-content: 1,
                },
              }
              }]]
          }
        }),
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.flake8.with({
          extra_args = { "--max-line-length", "130" },
        }),
        -- null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.ansiblelint,
      } }
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    config = function()
      require 'config.nvim-cmp'
    end,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'zjp-CN/nvim-cmp-lsp-rs' },
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
        vim.keymap.set('n', ']c', function() require('gitsigns').next_hunk() end, { buffer = true })
        vim.keymap.set('n', '[c', function() require('gitsigns').prev_hunk() end, { buffer = true })
        vim.keymap.set('n', ']=', function() require('gitsigns').toggle_deleted() end, { buffer = true })
        vim.keymap.set('n', ']~', function() require('gitsigns').diffthis() end, { buffer = true })
        vim.keymap.set('n', ']-', function() require('gitsigns').preview_hunk() end, { buffer = true })
        vim.keymap.set('n', ']+', function() require('gitsigns').select_hunk() end, { buffer = true })
      end,
    },
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

  {
    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
    opts = {}
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'config.telescope'
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable 'make' == 1
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>U",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          mappings = {
            i = {
              ["<cr>"] = function(bufnr)
                return require("telescope-undo.actions").restore(bufnr)
              end,
              ["<C-y>"] = function(bufnr)
                return require("telescope-undo.actions").yank_additions(bufnr)
              end,
            },
            n = {
              ["<cr>"] = function(bufnr)
                return require("telescope-undo.actions").restore(bufnr)
              end,
              ["y"] = function(bufnr)
                return require("telescope-undo.actions").yank_additions(bufnr)
              end,
            },
          },
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
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
  {
    'mfussenegger/nvim-dap',
    config = function()
      require 'config.nvim-dap'
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require 'config.nvim-dap-ui'
    end
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },

  {
    'Eandrju/cellular-automaton.nvim',
    config = function()
      vim.keymap.set('n', 'q:', '<cmd>CellularAutomaton make_it_rain<CR>')
    end
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        trigger = "\\",
      }
    },
    -- stylua: ignore
    keys = {
      { "<leader><leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "<leader>S",         mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",                 mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",                 mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>",             mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    'mhartington/formatter.nvim',
    config = function()
      require("formatter").setup {
        filetype = { yaml = { require("formatter.filetypes.yaml").yamlfmt } }
      }
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },

  -- LSP diagnostics at your corner.
  -- Messes up visual selection..
  -- { 'RaafatTurki/corn.nvim',
  --   opts = {},
  -- },
  {
    'dgagn/diagflow.nvim',
    opts = {},
    event = "VeryLazy",
  },

  {
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
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup()
    end
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    branch = "dev", -- IMPORTANT!
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xd",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
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
    "OXY2DEV/markview.nvim",
    lazy = false, -- Not needed, already handled by plugin

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        'gQ',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters = {
        ruff = {
          prepend_args = { "--config", "~/Documents/cdmi/automation/meta-files/ruff.toml" },
        },
      },
      formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
        python = { "ruff", lsp_format = "fallback" },
        -- python = { "black", lsp_format = "fallback" },
        --   -- lua = { 'stylua' },
        --   -- Conform can also run multiple formatters sequentially
        --   -- python = { "isort", "black" },
        --   --
        --   -- You can use 'stop_after_first' to run the first available formatter from the list
        --   -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
