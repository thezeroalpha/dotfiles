local function symbols()
  local server_ready = not not vim.lsp.buf_notify(0, '$/progress', {})
  if server_ready then
    Snacks.picker.lsp_symbols()
  else
    Snacks.picker.treesitter()
  end
end

local keys = {
  -- Top Pickers & Explorer
  { "<leader>s<space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
  { "<leader>b",        function() Snacks.picker.buffers() end,         desc = "Buffers" },
  { "<leader>sg",       function() Snacks.picker.grep() end,            desc = "Grep" },
  { "<leader>s;",       function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>sn",       function() Snacks.picker.notifications() end,   desc = "Notification History" },
  {
    "<leader>f",
    function()
      local explorer_pickers = Snacks.picker.get({ source = "explorer" })
      for _, v in pairs(explorer_pickers) do
        if v:is_focused() then
          v:close()
        else
          v:focus()
        end
      end
      if #explorer_pickers == 0 then
        Snacks.picker.explorer()
      end
    end,

    desc = "Explorer"
  },
  -- find
  { "<leader>sc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>sf", function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>sv", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
  { "<leader>sP", function() Snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>sp", function() Snacks.picker.recent() end,                                  desc = "Recent" },
  -- git
  { "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
  -- Grep
  { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
  { "<leader>sg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
  { '<leader>s/', function() Snacks.picker.search_history() end,                          desc = "Search History" },
  { "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
  { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sC", function() Snacks.picker.commands() end,                                desc = "Commands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
  { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
  { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
  { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
  { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
  { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
  { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
  { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
  { "<leader>sR", function() Snacks.picker.resume() end,                                  desc = "Resume" },
  { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
  { "<leader>uC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
  -- LSP
  { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  { "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
  { "<leader>sr", function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
  { "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  { "gy",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  { "<leader>ss", symbols,                                                                desc = "LSP Symbols" },
  { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
  -- Other
}

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  desc = 'Show LSP loading progress',
  group = vim.api.nvim_create_augroup('LspProgress', { clear = true }),

  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params
        .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      win = {
        preview = {
          wo = {
            foldlevel = 99,
            foldenable = false,
          },
        },
      },
      sources =
      {
        ---@class snacks.picker.Explorer.Config
        explorer = {
          jump = { close = true },
          win = {
            list = {
              keys = {
                ["-"] = "explorer_up",
              }
            }
          },
        },
      }
    },
    animate = {},
    notifier = {},
    indent = {
      enabled = true,
      indent = {
        char = '┊',
      },
    },
    input = {},
  },
  keys = keys,
}
