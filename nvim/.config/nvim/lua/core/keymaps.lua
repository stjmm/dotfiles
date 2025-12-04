local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Pane navigation
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Move code up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })

-- Center cursor when jumping around
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with centered cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with centered cursor" })

-- Centers cursor on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clears search highlight with ESC
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlight", silent = true, noremap = true })

-- Indent without exiting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Don't register when x
vim.keymap.set("n", "x", '"_x', opts)

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word globally" })

vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format)

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    local file_path = vim.fn.expand("%:~")
    vim.fn.setreg("+", file_path)
    print("File path copied to clipboard: " .. file_path)
end, { desc = "Copy file path to clipboard" })
