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
vim.keymap.set('n','<C-M>', ":make")
vim.keymap.set('n','<C-R>r', ":source % ")
vim.keymap.set('n','<leader>l', ":Lazy ")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("n", "<leader>B", vim.cmd.Ex)
vim.keymap.set("n","<C-S>",vim.cmd.w)
vim.keymap.set("v","J",":m '>+1<CR>gv=gv")
vim.keymap.set("v","K",":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


vim.keymap.set('n', '<leader>s', function()
  vim.cmd('botright split')
  vim.cmd('resize 12')
  vim.cmd('lcd %:p:h')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end)

