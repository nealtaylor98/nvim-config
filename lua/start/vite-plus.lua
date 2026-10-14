-- Vite+ projects keep Oxlint/Oxfmt config in vite.config.ts, which only `vp` reads
-- (standalone oxlint/oxfmt and their LSPs ignore it), so lint and format go through `vp`.
local M = {}

M.filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

local config_files = { 'vite.config.ts', 'vite.config.mts', 'vite.config.js', 'vite.config.mjs' }

function M.root(bufnr)
  return vim.fs.root(bufnr, config_files)
end

function M.bin(bufnr)
  local root = M.root(bufnr)
  if not root then
    return nil
  end
  local exe = vim.fs.joinpath(root, 'node_modules', '.bin', vim.fn.has 'win32' == 1 and 'vp.cmd' or 'vp')
  return vim.fn.executable(exe) == 1 and exe or nil
end

return M
