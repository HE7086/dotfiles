return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'tpope/vim-surround'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-commentary'}
    -- use {'tpope/vim-fugitive'}
    use {'terryma/vim-multiple-cursors'}
    use {'Konfekt/vim-CtrlXA'}
    use {'rakr/vim-one'}
    use {'kyazdani42/nvim-web-devicons'}

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
        run = 'cd app && yarn install',
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

    ----- lsp plugins -----
    use {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.nvim-treesitter') end
    }
    use {'neovim/nvim-lspconfig',
        config = function() require('plugins.lsp') end
    }
    use {'nvim-lua/completion-nvim',
        config = function() require('plugins.completion-nvim') end
    }
    use {'nvim-treesitter/completion-treesitter',
        requires = {
            {'nvim-lua/completion-nvim'},
            {'nvim-treesitter/nvim-treesitter'},
        },
        config = function() require('plugins.completion-treesitter') end
    }

end)
