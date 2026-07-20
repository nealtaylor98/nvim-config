return {
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    dependencies = {
      'Tastyep/structlog.nvim', -- Optional but recommended for logging
    },
    config = function()
      require('roslyn').setup {
        args = {
          '--logLevel=Information',
          '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
        },
        -- Pass your standard LSP capabilities and on_attach keys here
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = function(client, bufnr)
          -- Your custom global LSP keymaps go here (e.g., gd for go-to-definition)
        end,
      }
    end,
  },
}
