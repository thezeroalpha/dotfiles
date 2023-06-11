local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = 'codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
vim.keymap.set('n', '<localleader>dc', function() require('dap').continue() end, { desc = '[D]ebug [c]ontinue' })
vim.keymap.set('n', '<localleader>dn', function() require('dap').step_over() end, { desc = '[D]ebug [n]ext' })
vim.keymap.set('n', '<localleader>di', function() require('dap').step_into() end, { desc = '[D]ebug [i]n' })
vim.keymap.set('n', '<localleader>df', function() require('dap').step_out() end, { desc = '[D]ebug [f]inish' })
vim.keymap.set('n', '<localleader>db', function() require('dap').toggle_breakpoint() end, { desc = '[D]ebug [b]reak toggle' })
vim.keymap.set('n', '<localleader>dB', function() require('dap').set_breakpoint() end, { desc = '[D]ebug [B]reak set' })
vim.keymap.set('n', '<localleader>dm', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = '[D]ebug [m]essage' })
vim.keymap.set('n', '<localleader>dr', function() require('dap').repl.open() end, { desc = '[D]ebug [r]epl' })
vim.keymap.set('n', '<localleader>dC', function() require('dap').run_last() end, { desc = '[D]ebug last' })
vim.keymap.set('n', '<localleader>dj', function() require('dap').focus_frame() end, { desc = '[D]ebug [j]ump to frame' })
vim.keymap.set('n', '<localleader>dH', function() require('dap').goto_(nil) end, { desc = '[D]ebug [H]ere' })
vim.keymap.set('n', '<localleader>dS', function() require('dap').close() end, { desc = '[D]ebug [S]top' })
