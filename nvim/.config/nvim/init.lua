vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = { delay = 300 },
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
	    },
    },
    {
        "EdenEast/nightfox.nvim",
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false,
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
})
local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
    }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities,
})


vim.cmd("syntax on")

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.scrolloff = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("i", "jj", "<Esc>", { desc = "挿入モードを終了" })
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "ファイルを検索" })
-- 警告詳細
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "診断の詳細を表示" })
-- Code Action（VSCodeの Ctrl+. に近い）
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "コードアクション" })
-- 定義へ移動
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "定義へ移動" })
-- ホバー説明
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "ホバー情報を表示" })

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", { desc = "ファイルツリーを切り替え" })

vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "左のウィンドウへ移動" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "下のウィンドウへ移動" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "上のウィンドウへ移動" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "右のウィンドウへ移動" })

vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
vim.cmd("colorscheme nightfox")
