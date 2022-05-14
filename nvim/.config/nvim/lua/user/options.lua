-- NVIM options

vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- smart case
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = true                         -- show things like -- INSERT -- 
vim.opt.showtabline = 1                         -- show tabs when more than one
vim.opt.smartindent = false                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.autoindent = true
vim.opt.cursorline = false                      -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true                             -- display lines as one long line
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8                           -- when scrolling leave x lines above or bellow
vim.opt.sidescrolloff = 8                       -- same but for side scroll
vim.opt.inccommand = "split"
vim.opt.hidden = true                           -- enable hidden buffers
vim.opt.autoread = true                         -- auto update file
--vim.opt.showbreak = "↴ "                         -- show line breaks
--vim.opt.showbreak = "↪ "                         -- show line breaks
vim.opt.listchars = "tab:→ ,nbsp:·,trail:×,extends:›,precedes:‹"
--vim.opt.listchars = "trail:×"
vim.opt.list = true                             -- show hidden chars

vim.cmd('set nostartofline')
-- vim.opt.shortmess:append "c"                 -- TODO: Look into this in the future

-- vim.cmd [[set iskeyword+=-]]                 -- which chars constitute a word
-- vim.cmd [[set formatoptions-=cro]]           -- TODO: Look into this in the future
--

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.cmd('set nofoldenable')
