return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-fugitive' }
    use { 'tommcdo/vim-exchange' }
    use { 'terryma/vim-multiple-cursors' }
    use { 'Konfekt/vim-CtrlXA' }
    -- use {'rakr/vim-one',
    --     config = function()
    --         vim.g.one_allow_italics = 1
    --         vim.cmd 'colorscheme one'
    --     end
    -- }
    use { 'navarasu/onedark.nvim',
        config = function()
            vim.api.nvim_command("colorscheme onedark")
        end
    }

    use { 'cormacrelf/vim-colors-github',
        -- config = function()
        --     vim.cmd("colorscheme github")
        --     vim.cmd("set bg=light")
        -- end
    }

    -- use {'altercation/vim-colors-solarized',
    --     config = function()
    --         vim.cmd("colorscheme solarized")
    --         vim.cmd("set bg=light")
    --     end
    -- }
    use { 'kyazdani42/nvim-web-devicons' }

    -- use {'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     config = function() require('plugins.galaxyline') end,
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }

    use { 'skywind3000/asyncrun.vim' }
    use { 'Yggdroot/LeaderF',
        run = ':LeaderfInstallCExtension',
        config = function()
            require('plugins.leaderf')
        end
    }

    use { 'mhinz/vim-startify',
        config = function()
            require('plugins.startify')
        end
    }

    use { 'lewis6991/gitsigns.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
        config = function()
            require('plugins.gitsigns')
        end

    }

    use { 'iamcco/markdown-preview.nvim',
        run = function()
            vim.fn['mkdp#util#install']()
        end,
        ft = { 'markdown' },
        cmd = {
            'MarkdownPreview',
            'MarkdownPreviewToggle'
        }
    }

    use { 'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        },
        config = function()
            require('plugins.telescope')
        end
    }

    use { 'mhartington/formatter.nvim',
        config = function()
            require('plugins.formatter')
        end
    }

    use { 'rust-lang/rust.vim' }
    use { 'HE7086/objdump.vim' }

    -- use {'rktjmp/lush.nvim'}
    use { 'killphi/vim-ebnf' }

    use { 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    -- use {'SirVer/ultisnips',
    --     config = function() require('plugins.ultisnips') end,
    --     requires = {{'honza/vim-snippets'}}
    -- }

    ----- lsp plugins -----
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.nvim-treesitter')
        end
    }
    use { 'neovim/nvim-lspconfig',
        config = function()
            require('plugins.lsp')
        end
    }
    use { 'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.cmp')
        end,
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            -- {'SirVer/ultisnips'},
            -- {'quangnguyen30192/cmp-nvim-ultisnips'}
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },
            { 'onsails/lspkind.nvim' },
        }
    }
end)
