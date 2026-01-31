-- package manager
require("config.lazy")
-- theme 
require("plugins.theme")
vim.cmd.colorscheme "catppuccin"
vim.cmd([[
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
]])

-- keymap
vim.keymap.set('n','<C-S>', ":w ")
vim.keymap.set('n','<C-R>r', ":source % ")
vim.keymap.set('n','<leader>l', ":Lazy ")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
