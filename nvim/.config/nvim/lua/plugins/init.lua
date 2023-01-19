-- auto install packer.nvim
local check_packer = function()
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", "--depth=1", install_path })
        -- run PackerInstall to install plugins
        vim.api.nvim_command("packadd packer.nvim")
        return true
    end
    return false
end
local bootstrap = check_packer()

require("packer").startup({ function(use)
    use { "wbthomason/packer.nvim" }
    use { "tpope/vim-surround" }
    use { "tpope/vim-repeat" }
    use { "tpope/vim-commentary" }
    use { "tpope/vim-fugitive" }
    use { "tommcdo/vim-exchange" }
    use { "terryma/vim-multiple-cursors" } -- remove this causes markdown preview fail to install, but why?
    use { "Konfekt/vim-CtrlXA" }

    use { "rust-lang/rust.vim" }
    use { "HE7086/objdump.vim" }
    use { "killphi/vim-ebnf" }
    use { "LnL7/vim-nix" }

    use { "navarasu/onedark.nvim",
        config = function()
            pcall(require, "plugins.onedark")
        end
    }
    use { "cormacrelf/vim-colors-github" }
    use { "kyazdani42/nvim-web-devicons" }

    use { "skywind3000/asyncrun.vim" }

    use { "mhinz/vim-startify",
        config = function()
            pcall(require, "plugins.startify")
        end
    }

    use { "lewis6991/gitsigns.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            pcall(require, "plugins.gitsigns")
        end
    }

    use { "iamcco/markdown-preview.nvim",
        run = function()
            pcall(vim.fn["mkdp#util#install"])
        end,
        ft = { "markdown" },
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewToggle"
        }
    }

    use { "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        config = function()
            pcall(require, "plugins.telescope")
        end
    }

    use { "mhartington/formatter.nvim",
        config = function()
            pcall(require, "plugins.formatter")
        end
    }

    use { "lukas-reineke/indent-blankline.nvim",
        config = function()
            pcall(require, "plugins.indent-blankline")
        end
    }

    ----- lsp plugins -----
    use { "nvim-treesitter/nvim-treesitter-context",
        config = function()
            pcall(require, "plugins.nvim-treesitter-context")
        end,
        cmd = {
            "TSContextEnable",
            "TSContextDisable",
            "TSContextToggle",
        },
        requires = { "nvim-treesitter/nvim-treesitter" }
    }
    use { "nvim-treesitter/nvim-treesitter",
        -- run = ":TSUpdate",
        config = function()
            pcall(require, "plugins.nvim-treesitter")
        end
    }
    use { "neovim/nvim-lspconfig",
        config = function()
            pcall(require, "plugins.lsp")
        end
    }
    use { "hrsh7th/nvim-cmp",
        config = function()
            pcall(require, "plugins.cmp")
        end,
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
            { "onsails/lspkind.nvim" },
        }
    }
    -- use { "folke/trouble.nvim",
    --     requires = "kyazdani42/nvim-web-devicons",
    --     opt = true,
    --     event = "LspAttach",
    --     config = function()
    --         pcall(require, "plugins.trouble")
    --     end
    -- }
    use { "williamboman/mason.nvim",
        requires = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            pcall(require, "plugins.mason")
        end
    }

    use { vim.fn.stdpath("config") .. "/myplugins" }

    if bootstrap then
        require("packer").sync()
    end
end,
    config = {
        display = { open_fn = require("packer.util").float },
        profile = { enable = true },
    }
})
