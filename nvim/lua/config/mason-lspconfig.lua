local mason_lspconfig = require 'mason-lspconfig'
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  ansiblels = {},
  lua_ls = {
    ['Lua'] = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
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
    }
  },
  docker_compose_language_service = {},
  rust_analyzer = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
        -- extraEnv = {
        --   RUSTFLAGS = "--cfg tokio_unstable",
        -- },
      },
      -- Add clippy lints for Rust.
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = {
          -- "--no-deps",
          "--",
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
          "-A", "clippy::multiple_unsafe_ops_per_block", -- broken on 0.1.74
          "-A", "clippy::mod_module_files",
          "-A", "clippy::std_instead_of_alloc",
          "-A", "clippy::integer_division_remainder_used",
          "-D", "rust_2018_idioms",
          "-D", "missing_docs",
          "-D", "warnings",
          "-A", "clippy::too_many_lines"
        },
        --[[
        command = "check",
        ]]
        -- extraArgs = { "--no-deps" },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
  pyright = {},
  rubocop = {},
  -- solargraph = {},
  -- bashls = {},
  -- jdtls = {},
  -- jsonls = {},
  -- texlab = {},
  -- clangd = {},
  -- perlnavigator = {},
}


mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ra', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vim.keymap.set('v', '<leader>ra', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
