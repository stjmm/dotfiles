return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        telescope.load_extension("fzf")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                    },
                },
            }
        })

        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics,{ desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Find help tags" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles,   { desc = "Recent files" })
    end,
}
