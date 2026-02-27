-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- init.lua

local opt = vim.opt

opt.tabstop = 4 -- Tab 符号在屏幕上显示的宽度
opt.shiftwidth = 4 -- 每一级缩进占据的空格数
opt.softtabstop = 4 -- 插入 Tab 时实际转换成的空格数
opt.expandtab = true -- 将 Tab 键转换为空格
