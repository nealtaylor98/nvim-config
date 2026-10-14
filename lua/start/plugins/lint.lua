return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      local vp = require 'start.vite-plus'

      lint.linters.vp_lint = {
        name = 'vp_lint',
        cmd = function()
          return vp.bin(vim.api.nvim_get_current_buf())
        end,
        args = { 'lint', '-f', 'unix' },
        stdin = false,
        append_fname = true,
        stream = 'stdout',
        ignore_exitcode = true,
        parser = require('lint.parser').from_pattern(
          '^.-:(%d+):(%d+): (.-) %[(%a+)/(.-)%]$',
          { 'lnum', 'col', 'message', 'severity', 'code' },
          { Error = vim.diagnostic.severity.ERROR, Warning = vim.diagnostic.severity.WARN },
          { source = 'oxlint' }
        ),
      }

      -- vp lint reads the file on disk, so only lint when disk matches the buffer.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
        group = lint_augroup,
        callback = function(args)
          if vp.filetypes[vim.bo[args.buf].filetype] and vp.bin(args.buf) then
            lint.try_lint('vp_lint', { cwd = vp.root(args.buf) })
          end
        end,
      })
    end,
  },
}
