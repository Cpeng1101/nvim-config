local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        -- open_fn = function()
        --   return require("packer.util").float { border = "rounded" }
        -- end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- 主题
    use "lunarvim/colorschemes"
    use "navarasu/onedark.nvim"
    use "folke/tokyonight.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use "projekt0n/github-nvim-theme"

    -- 文件管理
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- BufferLine
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }

    -- 底部状态栏
    use "nvim-lualine/lualine.nvim"

    -- 快速查找
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- 模糊搜索
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
    use "nvim-telescope/telescope-ui-select.nvim" -- code action
    use "nvim-telescope/telescope-rg.nvim"
    use "nvim-telescope/telescope-dap.nvim"

    -- 语法高亮
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use "romgrk/nvim-treesitter-context"
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "kosayoda/nvim-lightbulb" -- code action
    use "ray-x/lsp_signature.nvim" -- 显示函数形参

    -- 补全
    use "hrsh7th/nvim-cmp"
    -- 补全源
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    -- 代码片段引擎
    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- 调试
    use "ravenxrz/DAPInstall.nvim"
    use 'mfussenegger/nvim-dap'
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"

    -- 通知样式
    use "rcarriga/nvim-notify"

    -- 括号补全
    use "windwp/nvim-autopairs"
    use "norcalli/nvim-colorizer.lua"

    -- 代码注释
    use "terrortylor/nvim-comment"

    -- 会话管理
    use "Shatur/neovim-session-manager"

    -- 代码竖线
    use "lukas-reineke/indent-blankline.nvim"

    -- Touble
    use "folke/trouble.nvim"

    -- cmake
    use "Shatur/neovim-cmake"

    -- 彩虹括号
    use "p00f/nvim-ts-rainbow"

    -- 代码大纲
    use "simrat39/symbols-outline.nvim"

    -- 显示LSP进度
    use "j-hui/fidget.nvim"

    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }

    use "folke/which-key.nvim"

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    use "folke/todo-comments.nvim"
    use "voldikss/vim-translator"
    use "Pocco81/HighStr.nvim"
end)
