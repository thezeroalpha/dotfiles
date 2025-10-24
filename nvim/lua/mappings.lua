local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end
local diag = vim.diagnostic

-- Diagnostic keymaps
map('[d', function() diag.jump({ count = -1, float = true }) end, 'Previous diagnostic')
map(']d', function() diag.jump({ count = 1, float = true }) end, 'Next diagnostic')
map('[e', function()
  diag.jump({ count = -1, float = true, severity = diag.severity.ERROR })
end, 'Previous error')
map(']e', function()
  diag.jump({ count = 1, float = true, severity = diag.severity.ERROR })
end, 'Next error')
map('[w', function()
  diag.jump({ count = -1, float = true, severity = diag.severity.WARN })
end, 'Previous warning')
map(']w', function()
  diag.jump({ count = 1, float = true, severity = diag.severity.WARN })
end, 'Next warning')

map('<leader>e', diag.open_float, 'Show errors')
map('<leader>q', function() diag.setloclist({ severity = diag.severity.ERROR }) end, 'Errors to quickfix')

-- 'i' that indents correctly on empty lines
vim.keymap.set('n', 'i', function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
