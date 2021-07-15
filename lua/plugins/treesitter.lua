local M = {}

M.config = function()
    local ts_config = require("nvim-treesitter.configs")

    ts_config.setup {
        ensure_installed = {
            "bash",
            "html",
            "css",
            "json",
            "javascript",
            "python",
            "php",
            "lua",
            -- "rust",
            "go"
        },
        highlight = {
            enable = true,
            use_languagetree = true
        }
    }
end

return M
