-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- 主题切换快捷键 (使用 <leader>u* 前缀, u = UI)
map("n", "<leader>ut", "<cmd>ThemeToggle<cr>", { desc = "Toggle Dark/Light Theme" })
map("n", "<leader>ud", "<cmd>ThemeDark<cr>", { desc = "Force Dark Theme" })
map("n", "<leader>ul", "<cmd>ThemeLight<cr>", { desc = "Force Light Theme" })
map("n", "<leader>ua", "<cmd>ThemeAuto<cr>", { desc = "Auto Theme (Follow System)" })
map("n", "<leader>us", "<cmd>ThemeSync<cr>", { desc = "Sync Theme with System" })
