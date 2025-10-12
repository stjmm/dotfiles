return {
    {
        "echasnovski/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            custom_surroundings = nil,

            highlight_duration = 300,

            mappings = {
                add = 'sa',            -- Add surrounding in Normal and Visual modes
                delete = 'ds',         -- Delete surrounding
                replace = 'sr',        -- Replace surrounding
            },

            n_lines = 20,

            respect_selection_type = false,

            silent = false,
        },
    },
}
