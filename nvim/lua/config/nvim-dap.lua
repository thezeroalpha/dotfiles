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
vim.keymap.set('n', '<localleader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<localleader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<localleader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<localleader>df', function() require('dap').step_out() end)
vim.keymap.set('n', '<localleader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<localleader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<localleader>dm', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<localleader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<localleader>dC', function() require('dap').run_last() end)
vim.keymap.set('n', '<localleader>dj', function() require('dap').focus_frame() end)
vim.keymap.set('n', '<localleader>dH', function() require('dap').goto_(nil) end)
vim.keymap.set('n', '<localleader>dS', function() require('dap').close() end)
