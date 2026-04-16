--- Options ---
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.undofile = true

--- Keymaps ---
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true, } )

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "x", '"_x')

vim.keymap.set("n", "<leader>fp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify("Yanked: " .. path)
end, { desc = "Copy absolute path" })

--- Autocommands ---

local augroup = vim.api.nvim_create_augroup("UserConfig", {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    callback = function() vim.highlight.on_yank() end,
})

--- Plugins ---
-- Colorscheme
vim.pack.add({ "https://github.com/vague-theme/vague.nvim"} )
vim.cmd("colorscheme vague")

-- Oil
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true },
    lsp_file_methods = { enabled = true, timeout_ms = 1000, },
    keymaps = { ["q"] = "actions.close" },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- mini
vim.pack.add({
    "https://github.com/nvim-mini/mini.pairs",
    "https://github.com/nvim-mini/mini.pick",
    "https://github.com/nvim-mini/mini.extra",
})
require("mini.pairs").setup()
require("mini.extra").setup()
require("mini.pick").setup({
    mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
    },
    options = { use_cache = true },
})
local pick = require("mini.pick")
local extra = require("mini.extra")
vim.keymap.set("n", "<leader>ff", function () pick.builtin.files() end)
vim.keymap.set("n", "<leader>fg", function () pick.builtin.grep_live() end)
vim.keymap.set("n", "<leader>G",  function () extra.pickers.git_commits() end)

-- Treesitter
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function() pcall(vim.treesitter.start) end,
})
require("nvim-treesitter").setup({ auto_install = true })
require("nvim-treesitter").install({
    "c", "cpp", "bash", "markdown", "lua", "python"
})

-- LSPConfig
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        local opts = { buffer = args.buf, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gq", vim.diagnostic.setqflist, opts)

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false} )
            vim.keymap.set("i", "<C-space>", "<C-x><C-o>", opts)
        end
    end,
})

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--compile-commands-dir=build"
    },
    init_options = {
        fallbackFlags = { "-std=c23" }
    }
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
        },
    },
})

vim.lsp.enable({ "clangd", "lua_ls"})
