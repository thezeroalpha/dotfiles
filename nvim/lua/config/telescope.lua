pcall(require('telescope').load_extension, 'fzf')
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
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>cv', function() require('telescope.builtin').find_files({ cwd = vim.env.DOTFILES..'/nvim' }) end, { desc = 'Neovim configs' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references, { desc = '[S]earch [R]eferences' })
vim.keymap.set('n', '<leader>sI', require('telescope.builtin').lsp_incoming_calls, { desc = '[S]earch [I]ncoming calls' })
vim.keymap.set('n', '<leader>sO', require('telescope.builtin').lsp_outgoing_calls, { desc = '[S]earch [O]utgoing calls' })
vim.keymap.set('n', '<leader>si', require('telescope.builtin').lsp_implementations, { desc = '[S]earch [i]mplementations' })
vim.keymap.set('n', '<leader>ss', function()
  local ok, lsp_buf = pcall(require, 'vim.lsp.buf')
  if ok and lsp_buf.server_ready() then
    require('telescope.builtin').lsp_dynamic_workspace_symbols()
  else
    require('telescope.builtin').treesitter()
  end
end, { desc = '[S]earch [S]ymbols' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sb', function()
  local ok, lsp_buf = pcall(require, 'vim.lsp.buf')
  if ok and lsp_buf.server_ready() then
    require('telescope.builtin').lsp_document_symbols()
  else
    require('telescope.builtin').tags()
  end
end, { desc = 'Telescope [T]ags' })
