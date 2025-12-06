-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- Enable inlay hints for current buffer
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ra", vim.lsp.buf.code_action, "[C]ode [A]ction")
  vim.keymap.set("v", "<leader>ra", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  vim.api.nvim_buf_create_user_command(bufnr, "LspInspect", function(_)
    vim.ui.input({ prompt = "Enter LSP Client name: " }, function(client_name)
      if client_name then
        local client = vim.lsp.get_clients({ name = client_name })

        if #client == 0 then
          vim.notify("No active LSP clients found with this name: " .. client_name, vim.log.levels.WARN)
          return
        end

        -- Create a temporary buffer to show the configuration
        local buf = vim.api.nvim_create_buf(false, true)
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = math.floor(vim.o.columns * 0.75),
          height = math.floor(vim.o.lines * 0.90),
          col = math.floor(vim.o.columns * 0.125),
          row = math.floor(vim.o.lines * 0.05),
          style = "minimal",
          border = "rounded",
          title = " " .. (client_name:gsub("^%l", string.upper)) .. ": LSP Configuration ",
          title_pos = "center",
        })

        local lines = {}
        for i, this_client in ipairs(client) do
          if i > 1 then
            table.insert(lines, string.rep("-", 80))
          end
          table.insert(lines, "Client: " .. this_client.name)
          table.insert(lines, "ID: " .. this_client.id)
          table.insert(lines, "")
          table.insert(lines, "Configuration:")

          local config_lines = vim.split(vim.inspect(this_client.config), "\n")
          vim.list_extend(lines, config_lines)
        end

        -- Set the lines in the buffer
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        -- Set buffer options
        vim.bo[buf].modifiable = false
        vim.bo[buf].filetype = "lua"
        vim.bo[buf].bh = "delete"

        vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
      end
    end)
  end, { desc = "Inspect LSP config" })
end

-- :h lspconfig-all
local config = function()
  vim.lsp.config("rust_analyzer", {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        workspace = {
          symbol = {
            search = {
              kind = "all_symbols",
            },
          },
        },
        check = {
          command = "clippy",
          features = "all",
          extraArgs = {
            "--",
            "--no-deps",
            "-D", "clippy::pedantic",
            "-D", "clippy::nursery",
            "-D", "clippy::restriction",
            "-A", "clippy::blanket_clippy_restriction_lints",
            "-A", "clippy::missing_docs_in_private_items",
            "-A", "clippy::implicit_return",
            "-A", "clippy::question_mark_used",
            "-A", "clippy::min_ident_chars",
            "-A", "clippy::pattern_type_mismatch",
            "-A", "clippy::single_call_fn",
            "-A", "clippy::as_conversions",
            "-A", "clippy::pub_with_shorthand",
            "-A", "clippy::shadow_reuse",
            "-A", "clippy::separated_literal_suffix",
            "-A", "clippy::float_arithmetic",
            "-A", "clippy::pub_use",
            "-A", "clippy::single_char_lifetime_names",
            "-A", "clippy::missing_trait_methods",
            "-A", "clippy::mod_module_files",
            "-A", "clippy::std_instead_of_alloc",
            "-A", "clippy::integer_division_remainder_used",
            "-D", "rust_2018_idioms",
            "-D", "missing_docs",
            "-D", "warnings",
            "-A", "clippy::too_many_lines",
            "-A", "clippy::arbitrary_source_item_ordering",
            "-A", "clippy::redundant_test_prefix",
            "-A", "clippy::cognitive_complexity",
          },
        },
      },
    },
  })
  vim.lsp.enable("rust_analyzer")

  vim.lsp.config("bacon_ls", {
    on_attach = on_attach,
    init_options = {
      updateOnSave = true,
      updateOnSaveWaitMillis = 3000,
      updateOnChange = true,
    },
  })
  --[[
  Some issues I found:
    - bacon-ls kept running after vim closed
    - diagnostics did not update, the old ones showed, I had to :e to refresh
  --]]
  -- vim.lsp.enable('bacon_ls')

  vim.lsp.config("yamlls", { on_attach = on_attach })
  vim.lsp.enable("yamlls")

  vim.lsp.config("nixd", { on_attach = on_attach })
  vim.lsp.enable("nixd", {
    opts = {
      root_markers = { "flake.nix", ".git", "darwin-configuration.nix" },
    },
  })

  vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            "vim",
            "require",
            "hs",
            "spoon",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")

  vim.lsp.enable("basedpyright")

  -- vim.lsp.config("ty", {
  --   settings = {
  --     ty = {
  --       diagnosticMode = 'workspace',
  --     },
  --   },
  -- })
  -- vim.lsp.enable("ty")

  -- vim.lsp.config("vue_ls", {
  --   -- add filetypes for typescript, javascript and vue
  --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  -- })
  -- vim.lsp.enable("vue_ls")

  vim.lsp.enable("terraformls")

  vim.lsp.config("ruby_lsp", {
    init_options = {
      formatter = "standard",
      linters = { "standard" },
    },
  })
  vim.lsp.enable("ruby_lsp")

  vim.lsp.enable('ansiblels')

  vim.lsp.enable('clangd')
end

return {
  {
    "neovim/nvim-lspconfig",
    config = config,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        sh = { "shellcheck" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
