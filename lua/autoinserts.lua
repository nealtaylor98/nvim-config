-- probably looks messy but whatever
vim.keymap.set('i', '{<CR>', '{}<C-c>i<CR><CR><C-c>kddO', { desc = 'auto create code block with newline' })

-- Make is so that if I press i -> Enter, it will open the code block beneath like vscode does
vim.keymap.set('n', 'i<CR>', 'i<CR><CR><C-c>kddO', { desc = 'automatic new line and tabbing inside code block' })
