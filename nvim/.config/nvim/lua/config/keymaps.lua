-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Close buffer with Space + Ctrl + w (using LazyVim's default safe buffer delete)
vim.keymap.set("n", "<leader><C-w>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
