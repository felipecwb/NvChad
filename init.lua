-- load all plugins
require "pluginList"
require "options"

local g = vim.g

g.mapleader = ","
g.auto_save = false

-- colorscheme
--vim.cmd("colorscheme sonokai")
require "zephyr"

g.nvchad_theme = "onedark"

require "highlights"
require "mappings"
require "plugins.bufferline"

require("utils").hideStuff()
