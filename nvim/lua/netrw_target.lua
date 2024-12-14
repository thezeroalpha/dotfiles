function TargetDir()
  local target = vim.api.nvim_call_function('netrw#Expose', { 'netrwmftgt' })
  if target == 'n/a' then
    return 'No target set'
  else
    target = target:gsub("^" .. vim.loop.os_homedir(), "~")
    return 'Target: ' .. target .. ' '
  end
end

vim.api.nvim_create_augroup('netrw_target', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'netrw_target',
  pattern = 'netrw',
  callback = function()
    vim.opt_local.winbar = '%!v:lua.WinBarNetRW()'
  end
})

WinBarNetRW = function()
  return table.concat {
    '%#StatusLineNC#',
    TargetDir(),
  }
end
