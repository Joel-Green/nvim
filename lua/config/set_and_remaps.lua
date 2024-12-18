-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- vim.g.have_nerd_font = false
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
--
vim.opt.autoread = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  -- lead = '·',
  nbsp = '␣',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Quickfix Next', silent = true })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Quickfix Prev', silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Move stuff around in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move Up', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Down', silent = true })
vim.keymap.set('v', 'L', '>gv', { desc = 'Move Right', silent = true })
vim.keymap.set('v', 'H', '<gv', { desc = 'Move Left', silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>cp', ':cd %:p:h<CR>', { desc = 'cd to [P]arent directory', silent = true })

-- paste without replacing
vim.keymap.set('x', '<leader>p', '"_dP')

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/lua/custom/snippets.lua<CR>', { desc = 'reload snippets', silent = true })

vim.keymap.set('n', '<leader>_', '<CMD>Oil<CR>', { desc = 'Open parent directory in Oil' })
vim.keymap.set('n', '<leader>-', '<CMD>Oil<CR>', { desc = 'Open parent directory in Oil' })
