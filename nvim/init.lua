-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

vim.opt.wrap = true
vim.opt.textwidth = 80
vim.g.neovide_opacity = 0.5
vim.g.neovide_normal_opacity = 0.5
vim.g.neovide_background_color = ("#0f1117" .. string.format("%x", math.floor(((255 * vim.g.neovide_opacity) or 0.8))))
vim.g.neovide_window_blurred = true
vim.o.guifont = "JetBrainsMono Nerd Font:h14"
vim.g.clipboard = "osc52"
