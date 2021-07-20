local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- abbreviations
vim.api.nvim_exec(
    [[
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
    ]],
    true
)

-- dont copy any deleted/substitute text
map("n", "d", "\"_d", opt)
map("v", "d", "\"_d", opt)
map("n", "D", "\"_D", opt)
map("v", "D", "\"_D", opt)
map("n", "s", "\"_s", opt)
map("v", "s", "\"_s", opt)
map("n", "S", "\"_S", opt)
map("v", "S", "\"_S", opt)
map("n", "<Leader>d", "\"+d", opt)
map("n", "<Leader>D", "\"+D", opt)
map("v", "<Leader>d", "\"+d", opt)
map("v", "<Leader>D", "\"+D", opt)
map("n", "<Leader>s", "\"+s", opt)
map("n", "<Leader>S", "\"+S", opt)
map("v", "<Leader>s", "\"+s", opt)
map("v", "<Leader>S", "\"+S", opt)

-- OPEN TERMINALS --
map("n", "<Leader>sh", [[<Cmd> tabnew | term <CR>]], opt) -- term newtab
map("n", "<Leader>t", [[<Cmd> split term://bash | resize 10 <CR>]], opt) --  term bottom

-- select whole content
map("n", "<C-a>", "ggVG", opt)

-- save
map("n", "<C-s>", ":w <CR>", opt)

-- Commenter Keybinding
map("n", "<Leader>/", ":CommentToggle<CR>", opt)
map("v", "<Leader>/", ":CommentToggle<CR>", opt)

-- reselect with indent
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- duplicate lines
map("v", "<C-d>", [["1y"1P]], opt)
map("n", "<C-d>", [["1Y"1P]], opt)

-- Move visual block
map("n", "<S-Up>", ":move -2<CR>", opt)
map("n", "<S-Down>", ":move +1<CR>", opt)
map("v", "<S-Up>", ":'<,'>move '<-2<CR>gv", opt)
map("v", "<S-Down>", ":'<,'>move '>+1<CR>gv", opt)

-- search
map("n", "n", "nzzzv", opt)
map("n", "N", "Nzzzv", opt)
map("n", "<Leader><Space>", ":nohlsearch<CR>", opt)
map("v", "*", ":call visualselection('f')<CR>", opt)
map("v", "#", ":call visualselection('b')<CR>", opt)

-- compe stuff
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

--  compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<CR>", "v:lua.completions()", {expr = true})

-- nvimtree
map("n", "<S-e>", ":NvimTreeToggle<CR>", opt)

-- format code
map("n", "<Leader>nf", [[<Cmd> Neoformat<CR>]], opt)

-- dashboard stuff
map("n", "<Leader>db", [[<Cmd> Dashboard <CR>]], opt)
map("n", "<Leader>bm", [[<Cmd> DashboardJumpMarks <CR>]], opt)
map("n", "<Leader>fn", [[<Cmd> DashboardNewFile <CR>]], opt)

-- Telescope
map("n", "<C-p>", [[<Cmd> Telescope find_files <CR>]], opt)
map("n", "<S-b>", [[<Cmd> Telescope buffers <CR>]], opt)
map("n", "<S-f>", [[<Cmd> Telescope live_grep <CR>]], opt)
map("n", "<S-m>", [[<Cmd> Telescope media_files <CR>]], opt)
map("n", "<Leader>fo", [[<Cmd> Telescope oldfiles <CR>]], opt)
map("n", "<Leader>ft", [[<Cmd> Telescope tags <CR>]], opt)
map("n", "<Leader>fh", [[<Cmd> Telescope help_tags <CR>]], opt)
map("n", "<Leader>gs", [[<Cmd> Telescope git_status <CR>]], opt)
map("n", "<Leader>gc", [[<Cmd> Telescope git_commits <CR>]], opt)

-- sessions
map("n", "<C-s>l", [[<Cmd> SessionLoad<CR>]], opt)
map("n", "<C-s>s", [[<Cmd> SessionSave<CR>]], opt)

-- close buffer/tab
map("n", "<C-q>", ":bp<bar>sp<bar>bn<bar>bd! <CR>", opt)

-- bufferline tab stuff
map("n", "<S-t>", ":tabnew<CR>", opt) -- new tab
map("n", "<S-Esc>", ":bd!<CR>", opt) -- close tab

-- move between tabs
map("n", "<TAB>", [[<Cmd> BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd> BufferLineCyclePrev<CR>]], opt)

-- move windows
map("n", "<C-Up>", "<C-w>k", opt)
map("n", "<C-Down>", "<C-w>j", opt)
map("n", "<C-Left>", "<C-w>h", opt)
map("n", "<C-Right>", "<C-w>l", opt)

