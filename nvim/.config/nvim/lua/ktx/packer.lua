local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local use = require("packer").use
require("packer").startup({
	function()
		use("wbthomason/packer.nvim")

		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use("neovim/nvim-lspconfig")
		use("nvim-lua/plenary.nvim")
		use("jose-elias-alvarez/null-ls.nvim")
		use("lewis6991/gitsigns.nvim")
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})

		use({ "L3MON4D3/LuaSnip" })
		use({ "saadparwaiz1/cmp_luasnip" })

		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-cmdline")
		use({
			"petertriho/cmp-git",
			config = function()
				require("cmp_git").setup()
			end,
		})
		use("hrsh7th/nvim-cmp")

		use({
			"ray-x/go.nvim",
			config = function()
				require("go").setup()
			end,
		})

		use("onsails/lspkind-nvim")
		use("kyazdani42/nvim-web-devicons")
		use("kyazdani42/nvim-tree.lua")

		use("nvim-telescope/telescope.nvim")
		use("nvim-telescope/telescope-github.nvim")
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use("cljoly/telescope-repo.nvim")

		-- use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("nvim-treesitter/nvim-treesitter")
		use("nvim-treesitter/nvim-treesitter-textobjects")
		use("nvim-treesitter/playground")
		-- use 'nvim-treesitter/nvim-treesitter-context'
		use("JoosepAlviste/nvim-ts-context-commentstring")

		use("tpope/vim-sensible")
		use("tpope/vim-surround")
		use("tpope/vim-abolish")
		use("tpope/vim-unimpaired")
		use("tpope/vim-repeat")
		use("tpope/vim-sleuth")
		use("tpope/vim-rsi")
		use("tpope/vim-eunuch")
		use("tpope/vim-fugitive")
		use("tpope/vim-rhubarb")
		use("tpope/vim-vinegar")
		use("tpope/vim-dispatch")
		use("tpope/vim-obsession")
		use("tpope/vim-endwise")
		use("tpope/vim-commentary")
		use("tpope/vim-characterize")
		use("tpope/vim-capslock")

		use("tjdevries/colorbuddy.vim")
		use("~/ghq/github.com/jasonwoodland/onejson")

		-- use("jasonwoodland/vim-hyperstyle")
		use("jasonwoodland/vim-closer")
		use("michaeljsmith/vim-indent-object")
		use("AndrewRadev/splitjoin.vim")
		use("christianchiarulli/nvcode-color-schemes.vim")
		use("norcalli/nvim-colorizer.lua")
		use("andymass/vim-matchup")

		use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
			require('git-conflict').setup({
				default_mappings = false, -- disable buffer local mapping created by this plugin
				disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
			})
		end }

		-- use({
		-- 	"aarondiel/spread.nvim",
		-- 	after = "nvim-treesitter",
		-- 	config = function()
		-- 		local spread = require("spread")
		-- 		local default_options = {
		-- 			silent = true,
		-- 			noremap = true
		-- 		}

		-- 		vim.keymap.add("n", "<leader>ss", spread.out, default_options)
		-- 		vim.keymap.add("n", "<leader>sj", spread.combine, default_options)
		-- 	end
		-- })
	end,
	-- config = {
	-- 	display = {
	-- 		open_fn = require('packer.util').float,
	-- 	}
	-- }
})
