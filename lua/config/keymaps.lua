local map = vim.keymap.set

-- C = Ctrl
map('n', '<C-b>', '<Cmd>Neotree toggle<CR>') -- Open file tree
map('n', '<C-e>', '<Cmd>BufferLineCycleNext<CR>') -- Next tab
map('n', '<C-q>', '<Cmd>BufferLineCyclePrev<CR>') -- Prev tab

map('n', '<C-f>', '<cmd>Telescope live_grep<cr>') -- Text search

-- <leader> = \
map('n', '<leader><space>', '<cmd>Telescope buffers<cr>') -- Search currently open files
map('n', '<leader>?', '<cmd>Telescope oldfiles<cr>') -- Search history of files
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- Search all files from root
map('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
map('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>') -- Search in current file

-- CMake
local opts = { noremap = true, silent = true }
map("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Generate project" }))
map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Build project" }))
map("n", "<leader>cr", "<cmd>CMakeRun<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Run target" }))
map("n", "<leader>ct", "<cmd>CMakeSelectBuildType<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Select build type" }))
map("n", "<leader>cc", "<cmd>CMakeClean<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Clean project" }))
map("n", "<leader>cx", "<cmd>CMakeClose<CR>", vim.tbl_extend("force", opts, { desc = "CMake: Close terminal" }))

-- DAP (Debug Adapter Protocol)
local dap = require("dap")
local dapui = require("dapui")
map("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
map("n", "<F10>", dap.step_over, { desc = "Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Step Out" })
map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<Leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })
map("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
map("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
map("n", "<Leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
