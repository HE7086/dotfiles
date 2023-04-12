-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-commentary" },
    { "tpope/vim-fugitive" },
    { "tommcdo/vim-exchange" },
    { "terryma/vim-multiple-cursors" },
    { "Konfekt/vim-CtrlXA" },

    { "rust-lang/rust.vim" },
    { "HE7086/objdump.vim" },
    { "killphi/vim-ebnf" },
    { "LnL7/vim-nix" },

    { "navarasu/onedark.nvim",
        config = function()
            pcall(require, "plugins.onedark")
        end
    },
    { "cormacrelf/vim-colors-github",
        lazy = true
    },
    { "kyazdani42/nvim-web-devicons" },

    { "skywind3000/asyncrun.vim",
        lazy = true
    },

    { "mhinz/vim-startify",
        config = function()
            pcall(require, "plugins.startify")
        end
    },

    { "lewis6991/gitsigns.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            pcall(require, "plugins.gitsigns")
        end
    },

    { "iamcco/markdown-preview.nvim",
        build = function()
            pcall(vim.fn["mkdp#util#install"])
        end,
        ft = { "markdown" },
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewToggle"
        }
    },

    { "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
        },
        config = function()
            require("plugins.telescope")
        end
    },

    { "mhartington/formatter.nvim",
        config = function()
            pcall(require, "plugins.formatter")
        end
    },

    { "lukas-reineke/indent-blankline.nvim",
        config = function()
            pcall(require, "plugins.indent-blankline")
        end
    },

    ----- lsp plugins -----
    { "nvim-treesitter/nvim-treesitter-context",
        config = function()
            pcall(require, "plugins.nvim-treesitter-context")
        end,
        cmd = {
            "TSContextEnable",
            "TSContextDisable",
            "TSContextToggle",
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
    { "nvim-treesitter/nvim-treesitter",
        -- run = ":TSUpdate",
        config = function()
            pcall(require, "plugins.nvim-treesitter")
        end
    },
    { "neovim/nvim-lspconfig",
        config = function()
            pcall(require, "plugins.lsp")
        end
    },
    { "hrsh7th/nvim-cmp",
        config = function()
            pcall(require, "plugins.cmp")
        end,
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
            { "onsails/lspkind.nvim" },
        }
    },
    -- { "folke/trouble.nvim",
    --     dependencies = "kyazdani42/nvim-web-devicons",
    --     opt = true,
    --     event = "LspAttach",
    --     config = function()
    --         pcall(require, "plugins.trouble")
    --     end
    -- }
    { "williamboman/mason.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            pcall(require, "plugins.mason")
        end
    },

    { dir = vim.fn.stdpath("config") .. "/myplugins" },
}

local opts = {
    concurrency = 16,
}

require("lazy").setup(plugins, opts)
