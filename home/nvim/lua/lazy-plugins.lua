-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Colors
    { "folke/tokyonight.nvim", lazy = false },

    -- General
    { "tpope/vim-surround" },
    { "tpope/vim-unimpaired" },
    { "tpope/vim-endwise" },
    { "tpope/vim-sensible" },
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "editorconfig/editorconfig-vim" },

    -- Editing
    { "junegunn/vim-easy-align" },
    { "nvim-tree/nvim-tree.lua" },
    { "nvim-tree/nvim-web-devicons" },

    -- Development Tool Integration
    { "tpope/vim-fugitive" },
    { "tpope/vim-commentary" },
    -- { "gitub/copilot.vim" },
    { "joshuavial/aider.nvim", lazy = true },
    { "janko/vim-test" },

    -- Avante
    { "nvim-treesitter/nvim-treesitter", lazy = true },
    { "stevearc/dressing.nvim"},
    { "nvim-lua/plenary.nvim"},
    { "MunifTanjim/nui.nvim"},
    { "MeanderingProgrammer/render-markdown.nvim"},
    { "HakonHarnes/img-clip.nvim"},
    { "yetone/avante.nvim", lazy = true},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

