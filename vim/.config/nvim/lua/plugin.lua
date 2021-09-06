return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'tpope/vim-surround'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-fugitive'}
    use {'tommcdo/vim-exchange'}
    use {'terryma/vim-multiple-cursors'}
    use {'Konfekt/vim-CtrlXA'}
    use {'rakr/vim-one',
        config = function()
            vim.g.one_allow_italics = 1
            vim.cmd 'colorscheme one'
        end
    }
    use {'kyazdani42/nvim-web-devicons'}

    -- use {'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     config = function() require('plugins.galaxyline') end,
    --     requires = {'kyazdani42/nvim-web-devicons'}
    -- }

    use {'skywind3000/asyncrun.vim'}
    use {'Yggdroot/LeaderF',
        run = ':LeaderfInstallCExtension',
        config = function() require('plugins.leaderf') end
    }

    use {'mhinz/vim-startify',
        config = function() require('plugins.startify') end
    }

    use {'lewis6991/gitsigns.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
        },
        config = function() require('plugins.gitsigns') end

    }

    use {'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = {'markdown'},
        cmd = {
            'MarkdownPreview',
            'MarkdownPreviewToggle'
        }
    }

    use {'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
        config = function() require('plugins.telescope') end
    }

    use {'mhartington/formatter.nvim',
        config = function() require('plugins.formatter') end
    }

    -- use {'rktjmp/lush.nvim'}
    use {'killphi/vim-ebnf'}

    ----- lsp plugins -----
    use {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        branch = '0.5-compat', -- TODO: switch to master when 0.6 stable
        config = function() require('plugins.nvim-treesitter') end
    }
    use {'neovim/nvim-lspconfig',
        config = function() require('plugins.lsp') end
    }
    use {'nvim-lua/completion-nvim',
        config = function() require('plugins.completion-nvim') end,
        requires = {
            {'nvim-treesitter/completion-treesitter'},
            {'steelsojka/completion-buffers'},
            {'kristijanhusak/completion-tags'}
        }
    }
end)
