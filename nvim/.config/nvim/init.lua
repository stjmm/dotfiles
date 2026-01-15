--- Options ---
vim.g.mapleader = " "
vim.g.localleader = " "


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.showmode = false
vim.opt.smoothscroll = true
vim.opt.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

--- Keymaps ---
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines, keep cursor" })

vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlight", silent = true })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "x", '"_x')

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>fp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Yanked: ' .. path)
end, { desc = "Copy absolute path" })

vim.keymap.set("n", "<leader>rc", function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Edit Neovim config" })

--- Autocommands ---
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

--- Plugins ---
-- Colorscheme
vim.pack.add({
    "https://github.com/vague-theme/vague.nvim",
})
require("vague").setup({
    transparent = true,
})
vim.cmd("colorscheme vague")

-- Oil
vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
})
require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["q"] = "actions.close",
    }
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Lualine
vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
})
require("lualine").setup({
    options = {
        theme = (function ()
            local curr = require("vague.config.internal").current
            local colors = require("vague.groups.lualine").get_colors(curr)
            return colors
        end)(),
        section_separators = { left = " ", right = "" },
        component_separatos = { left = " ", right = "" },
    },
    lualine_b = { { "branch", separator = "|" } },
    lualine_c = {
      {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " },
      },
      { "filename", file_status = true, path = 0 },
    },
    lualine_x = { { "filetype" } },
})

-- mini and others
vim.pack.add({
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/nvim-mini/mini.pairs",
    "https://github.com/nvim-mini/mini.pick",
    "https://github.com/nvim-mini/mini.ai",
})
require("ibl").setup({})
require("mini.pairs").setup({})
require("mini.ai").setup({})
require("mini.pick").setup({
    mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
    },
    options = { use_cache = true },
})
local pick = require("mini.pick")
vim.keymap.set('n', '<leader>ff', function() pick.builtin.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', function() pick.builtin.grep_live() end, { desc = 'Grep Live' })
vim.keymap.set('n', '<leader>fb', function() pick.builtin.buffers() end, { desc = 'Find Buffers' })

-- Treesitter
-- This config uses Treesitters new main branch,
-- which removes some functionalities
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
require("nvim-treesitter").install({
    "c", "cpp", "bash", "markdown", "lua",
    "python", "javascript", "typescript",
})

-- LSP, Mason, Autocomplete
vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/Saghen/blink.cmp",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local opts = { buffer = args.buf, silent = true}

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "gq", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        -- Maybe use F3 to format a buffer
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
    end,
})

vim.lsp.config("lua_ls", {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})
vim.lsp.config("clangd", {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--completion-style=detailed',
    },
    init_options = {
        fallbackFlags = { '-std=c23' },
    },
})

require("blink.cmp").setup({
    keymap = {
        preset = 'default',
        ["<C-space>"] = { "show", "show_documentation"},
        ["<C-e>"] = { "hide" },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    },
    completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true, window = { border = "rounded" } },
        menu = { border = "rounded" },
    },
    appearance = { nerd_font_variant = 'mono' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    signature = { enabled = true },
	fuzzy = { implementation = "prefer_rust" }
})

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
    },
    handlers = {
        function(server_name)
            local config = vim.lsp.config[server_name] or {}

            config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)

            require("lspconfig")[server_name].setup(config)
        end,
    }
})

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    severity_sort = true,
    float = {
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
})

--- Format and lint ---
vim.pack.add({
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/stevearc/conform.nvim",
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "clang-format",
        "stylua",
        "black",
        "isort",
    }
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "isort", "black" },
    },

    vim.keymap.set({ "n", "v" }, "<leader><F3>", function ()
        require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
        })
        vim.notify("Formatted buffer")
    end, { desc = "Format file" })
})
