-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.java" },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   opts = {
  --     settings = {
  --       java = {
  --         configuration = {
  --           runtimes = {
  --             {
  --               name = "zulu-21",
  --               path = "/usr/lib/jvm/java-11-openjdk/",
  --             },
  --           },
  --         },
  --       },
  --       format = {
  --         enabled = true,
  --         settings = { -- you can use your preferred format style
  --           url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
  --           profile = "GoogleStyle",
  --         },
  --       },
  --     },
  --   },
  -- },
  -- { import = "astrocommunity.pack.jj" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.recipes.neovide" },
  -- { import = "astrocommunity.media.image-nvim" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.note-taking.obsidian-nvim" },
  { import = "astrocommunity.editing-support.bigfile-nvim" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.recipes.vscode" },
  -- import/override with your plugins folder
}
