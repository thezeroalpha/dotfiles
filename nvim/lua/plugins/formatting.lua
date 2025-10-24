-- Autoformat
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "gQ",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
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
      ruff_format = {
        inherit = true,
        append_args = { "--config", "~/Documents/cdmi/automation/meta-files/ruff.toml" },
      },
      stylua = {
        inherit = true,
        append_args = { "--indent-width", "2", "--indent-type", "Spaces" },
      },
    },
    formatters_by_ft = {
      rust = { "rustfmt", lsp_format = "fallback" },
      ruby = { "rubyfmt", lsp_format = "fallback" },
      python = { "ruff_format", "ruff_organize_imports", lsp_format = "fallback" },
      lua = { "stylua" },
      cpp = { "clang-format", lsp_format = "fallback" },

      -- python = { "black", lsp_format = "fallback" },
      --   -- lua = { 'stylua' },
      --   -- Conform can also run multiple formatters sequentially
      --   -- python = { "isort", "black" },
      --   --
      --   -- You can use 'stop_after_first' to run the first available formatter from the list
      --   -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
