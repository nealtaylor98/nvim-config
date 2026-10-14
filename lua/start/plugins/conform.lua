return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local ft = vim.bo[bufnr].filetype
        return {
          -- vp fmt starts node on every call (~0.7s).
          timeout_ms = require('start.vite-plus').filetypes[ft] and 3000 or 500,
          lsp_fallback = not disable_filetypes[ft],
        }
      end,
      formatters = {
        vp_fmt = {
          command = function(_, ctx)
            return require('start.vite-plus').bin(ctx.buf)
          end,
          args = { 'fmt', '--stdin-filepath', '$FILENAME' },
          stdin = true,
          cwd = function(_, ctx)
            return require('start.vite-plus').root(ctx.buf)
          end,
          condition = function(_, ctx)
            return require('start.vite-plus').bin(ctx.buf) ~= nil
          end,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        javascript = { 'vp_fmt', 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'vp_fmt', 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'vp_fmt', 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'vp_fmt', 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
