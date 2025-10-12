return {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = { },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-c>"] = false,
                ["q"] = "actions.close",
            },
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
        })

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory"} )

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                vim.opt_local_cursorline = true
            end,
        })
    end
}
