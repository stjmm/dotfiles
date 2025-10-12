return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
        { "<leader>gl", function() require("snacks").lazygit().log() end, desc = "Lazygit" },
    },
    opts = {
        bigfile = { enabled = true },
        indent = { enabled  = true },
        lazygit = { 
            enabled = true,
            args = { "--use-config-file=false" },
        },
    }
}
