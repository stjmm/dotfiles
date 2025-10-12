return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "vague.nvim" },
    config = function()
        local lualine = require("lualine")

        local curr_internal_conf =  require("vague.config.internal").current
        local theme = require("vague.groups.lualine").get_colors(curr_internal_conf)
        theme.visual.a.bg = "#d8647e"

        local mode = {
            "mode",
            fmt = function(str)
                --return " " .. str.upper(str)
                return str.upper(str)
            end,
        }

        local diff = {
            "diff",
            colored = false,
            symbols = { added = " ", modified = " ", removed = " " },
        }

        local filename = {
            "filename",
            file_status = true,
            path = 0,
        }

        local branch = { "branch", "|" }

        lualine.setup({
            options = {
                theme = theme,
                section_separators = { left = " ", right = "" },
                component_separators = { left = "|", right = " " },
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch },
                lualine_c = { diff, filename },
                lualine_x = {
                    { "filetype" },
                },
            },
        })
    end,
}
