-- Fuzzy Finder (files, lsp, etc)
local configure_telescope = function()
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }
  -- Call this after telescope's setup
  pcall(require('telescope').load_extension, 'fzf')

  -- Disable folding in Telescope's result window.
  vim.api.nvim_create_autocmd("FileType",
    { pattern = "TelescopeResults", command = [[setlocal nofoldenable foldlevelstart=99]] })

  local map = function(keys, desc, func, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { desc = desc })
  end
  local tsbuiltin = require 'telescope.builtin'

  map('<leader>sp', '[S]earch [p]reviously opened files', require('telescope.builtin').oldfiles)
  map('<leader>b', 'Find existing buffers', require('telescope.builtin').buffers)
  map('<leader>sf', '[S]earch [F]iles', require('telescope.builtin').find_files)
  map('<leader>cv', 'Neovim configs',
    function() require('telescope.builtin').find_files({ cwd = vim.env.DOTFILES .. '/nvim' }) end)
  map('<leader>sh', '[S]earch [H]elp', require('telescope.builtin').help_tags)
  map('<leader>sw', '[S]earch current [W]ord', require('telescope.builtin').grep_string)
  map('<leader>sg', '[S]earch by [G]rep', require('telescope.builtin').live_grep)
  map('<leader>sd', '[S]earch [D]iagnostics', require('telescope.builtin').diagnostics)
  map('<leader>sr', '[S]earch [R]eferences', require('telescope.builtin').lsp_references)
  map('<leader>s<', '[S]earch [I]ncoming calls', require('telescope.builtin').lsp_incoming_calls)
  map('<leader>s>', '[S]earch [O]utgoing calls', require('telescope.builtin').lsp_outgoing_calls)
  map('<leader>st', '[Search] [T]his buffer', require('telescope.builtin').current_buffer_fuzzy_find)
  map('<leader>sI', '[S]earch [i]mplementations', require('telescope.builtin').lsp_implementations)
  map('<leader>sj', '[S]earch [J]umplist', require('telescope.builtin').jumplist)
  map('<leader>ss', '[S]earch [S]ymbols', function()
    local server_ready = not not vim.lsp.buf_notify(0, '$/progress', {})
    if server_ready then
      require('telescope.builtin').lsp_dynamic_workspace_symbols()
    else
      require('telescope.builtin').treesitter()
    end
  end)
  map('<leader>sb', 'Telescope [T]ags', function()
    local server_ready = not not vim.lsp.buf_notify(0, '$/progress', {})
    if server_ready then
      require('telescope.builtin').lsp_document_symbols()
    else
      require('telescope.builtin').tags()
    end
  end)
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = configure_telescope,
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable 'make' == 1
  },

}
