local packer = require("packer")
local use = packer.use

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    },
    git = {
        clone_timeout = 600 -- Timeout, in seconds, for git clones
    }
}

return packer.startup(
    function()
        use "wbthomason/packer.nvim"

        use "akinsho/nvim-bufferline.lua"

        use {
            "glepnir/galaxyline.nvim",
            config = function()
                require("plugins.statusline").config()
            end
        }

        -- color related stuff
        -- use "norcalli/nvim-base16.lua"
        -- use "sainnhe/sonokai"
        use "glepnir/zephyr-nvim"

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
                vim.cmd("ColorizerReloadAllBuffers")
            end
        }

        -- more syntax highlight
        use "sheerun/vim-polyglot"

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("plugins.treesitter").config()
            end
        }

        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufRead"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require("plugins.lspconfig").config()
            end
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("lspkind").init()
            end
        }

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("plugins.compe").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("plugins.compe").snippets()
                    end
                },
                {
                    "rafamadriz/friendly-snippets",
                    event = "InsertCharPre"
                }
            }
        }

        use {"sbdchd/neoformat", cmd = "Neoformat"}

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeRefresh" }, -- "NvimTreeToggle",
            config = function()
                require("plugins.nvimtree").config()
                require('nvim-tree').setup {}
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("plugins.icons").config()
            end
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-media-files.nvim"}
            },
            cmd = "Telescope",
            config = function()
                require("plugins.telescope").config()
            end
        }

        -- git stuff
        use 'tpope/vim-fugitive'

        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("plugins.gitsigns").config()
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require("nvim-autopairs").setup()
                require("nvim-autopairs.completion.compe").setup(
                    {
                        map_cr = true,
                        map_complete = true -- insert () func completion
                    }
                )
            end
        }

        use {"andymass/vim-matchup", event = "CursorMoved"}

        use {
            "terrortylor/nvim-comment",
            cmd = "CommentToggle",
            config = function()
                require("nvim_comment").setup()
            end
        }

        -- multi cursor
        use 'mg979/vim-visual-multi'

        use {
            "glepnir/dashboard-nvim",
            -- cmd = {
            --     "Dashboard",
            --     "DashboardNewFile",
            --     "DashboardJumpMarks",
            --     "SessionLoad",
            --     "SessionSave"
            -- },
            setup = function()
                require("plugins.dashboard").config()
            end
        }

        -- load autosave only if its globally enabled
        use {
            "Pocco81/AutoSave.nvim",
            config = function()
                require("plugins.zenmode").autoSave()
            end,
            cond = function()
                return vim.g.auto_save == true
            end
        }

        --   use "alvan/vim-closetag" -- for html autoclosing tag
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                require("utils").blankline()
            end
        }
    end
)
