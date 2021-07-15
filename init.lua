-- load all plugins
require "pluginList"
require "options"

local g = vim.g

g.mapleader = ","
g.auto_save = false

-- colorscheme related stuff
g.nvchad_theme = "onedark"
local base16 = require "base16"
base16(base16.themes["onedark"], true)

-- g.sonokai_style = 'atlantis'
-- g.sonokai_enable_italic = 1
-- g.sonokai_disable_italic_comment = 1
-- vim.api.nvim_command("colorscheme sonokai")

require "highlights"
require "mappings"
require "plugins.bufferline"

require("utils").hideStuff()
