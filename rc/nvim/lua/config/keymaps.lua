-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("", "Y", '"*y', { desc = "Copy To Clipboard" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Tab Next" })
vim.keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Tab Previous" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Buf Next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Buf Previous" })
vim.keymap.set("n", "<leader>ve", "<cmd>vsplit $MYVIMRC<cr>", { desc = "Edit Nvim Config" })
vim.keymap.set("n", "<leader>vs", "<cmd>source $MYVIMRC<cr>", { desc = "Source Nvim Config" })
