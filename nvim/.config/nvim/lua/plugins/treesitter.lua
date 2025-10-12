return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            highlight = {
                enable = true,
            },

            indent = { enable = true },

            ensure_installed = {
                "c",
                "cpp",
                "rust",
                "lua",
                "python",
                "javascript",
                "typescript",
                "go",
                "markdown",
                "markdown_inline",
                "glsl",
                "bash",
                "tsx",
                "vim",
                "gitignore",
            },

            additional_vim_regex_highlighting = false,
        })
    end,
}
