-- plugins made by @Pocco81 =)

local M = {}

-- autosave.nvim plugin disabled by default
M.autoSave = function()
    local autosave = require("autosave")

    autosave.setup(
        {
            enabled = vim.g.auto_save, -- takes boolean value from init.lua
            execution_message = "autosaved at : " .. vim.fn.strftime("%H:%M:%S"),
            events = {"InsertLeave", "TextChanged"},
            conditions = {
                exists = true,
                filetype_is_not = {},
                modifiable = true
            },
            write_all_buffers = true,
            on_off_commands = true,
            clean_command_line_interval = 2500
        }
    )
end

return M
