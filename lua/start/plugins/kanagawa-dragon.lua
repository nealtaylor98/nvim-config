return {
  {
    'rose-pine/neovim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      require('rose-pine').setup {
        styles = {
          italic = false,
        },
      }
      vim.cmd.colorscheme 'rose-pine'
      vim.cmd.hi 'Comment gui=italic'
      vim.o.winborder = 'rounded'
    end,
  },
}
