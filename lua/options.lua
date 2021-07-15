local opt = vim.opt


opt.encoding = "utf-8"
opt.fileformats = "unix,dos,mac"
opt.wrap = false
opt.ruler = false
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.list = true
opt.listchars = "tab:▸→,extends:❯,precedes:❮,trail:·"
opt.showbreak = "↪"
opt.clipboard = "unnamedplus"
opt.backspace = "indent,eol,start"
opt.autoread = true
-- opt.backup = false
-- opt.swapfile = false
opt.dir = "~/.vim/swap//,/var/tmp//,/tmp//,."
opt.tags = "~/.vim/tag//,/var/tmp//,/tmp//,"

-- Numbers
opt.number = true
opt.numberwidth = 2
-- opt.relativenumber = true

-- for indenline
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0

-- search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.magic = true

-- disable builtin vim plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_matchit = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_spec = 0

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

-- file extension specific tabbing
-- vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])

return M
