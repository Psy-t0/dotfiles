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
        "nvim-neo-tree/neo-tree.nvim",
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


vim.g.mapleader = " "


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

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>")
-- 警告詳細
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- Code Action（VSCodeの Ctrl+. に近い）
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
-- 定義へ移動
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
-- ホバー説明
vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>")

vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")

vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
vim.cmd("colorscheme nightfox")

