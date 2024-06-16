-- C = Ctrl
vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>') -- Open file tree
vim.keymap.set('n', '<C-e>', '<Cmd>BufferLineCycleNext<CR>') -- Next tab
vim.keymap.set('n', '<C-q>', '<Cmd>BufferLineCyclePrev<CR>') -- Prev tab

vim.keymap.set('n', '<C-f>', '<cmd>Telescope live_grep<cr>') -- Text search

-- <leader> = \
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>') -- Search currently open files
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>') -- Search history of files
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- Search all files from root
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>') -- Search in current file
