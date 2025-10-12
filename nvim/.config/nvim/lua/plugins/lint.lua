return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },

    config = function ()
        local lint = require("lint")
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            python = { "pylint" },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function ()
                lint.try_lint()
            end,
        })
    end
}
