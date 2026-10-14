return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- LSP hover floats: keep &nbsp; and escapes concealed on the cursor line when the float is focused
    overrides = {
      buftype = {
        nofile = {
          anti_conceal = { enabled = false },
          -- conceallevel 3 drops the " " replacement for &nbsp; entirely; 2 shows it
          win_options = { concealcursor = { rendered = 'nvic' }, conceallevel = { rendered = 2 } },
        },
      },
    },
  },
}
