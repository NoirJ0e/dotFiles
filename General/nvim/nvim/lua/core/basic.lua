vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮指针行
vim.wo.cursorline=true
-- 缩进 2 个空格等于一个 Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- 新行对齐当前行，空格替代 tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 边输入边搜索
vim.o.incsearch = true
-- 命令行高为 2，提供足够的显示空间
vim.o.cmdheight = 2
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.o.wrap = false
vim.wo.wrap = false
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.list = true
--vim.o.listchars = "space:·"
-- 补全增强
vim.o.wildmenu = true
-- always show tabline
vim.o.showtabline = 2
vim.o.mouse="a"
