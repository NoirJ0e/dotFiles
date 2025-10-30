---@type LazySpec
return {

  -- ==================== Themes ====================

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000, opts = {} },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },

  -- ==================== AI & Completion ====================

  -- Avante AI Assistant
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    opts = { provider = "claude-code" },
    acp_providers = {
      ["claude-code"] = {
        command = "npx",
        args = { "@zed-industries/claude-code-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Blink Completion with dictionary/thesaurus
  {
    "saghen/blink.cmp",
    dependencies = { "archie-judd/blink-cmp-words" },
    opts = {
      sources = {
        default = { "lsp", "path", "lazydev" },
        providers = {
          thesaurus = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.thesaurus",
            opts = {
              score_offset = 0,
              pointer_symbols = { "!", "&", "^" },
            },
          },
          dictionary = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.dictionary",
            opts = {
              dictionary_search_threshold = 3,
              score_offset = 0,
              pointer_symbols = { "!", "&", "^" },
            },
          },
        },
        per_filetype = {
          text = { "dictionary" },
          markdown = { "thesaurus" },
        },
      },
    },
  },

  -- nvim-cmp with custom Tab behavior for AI acceptance
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")
      if not opts.mapping then opts.mapping = {} end
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        local mini_snippets_avail, mini_snippets = pcall(require, "mini.snippets")
        local luasnip_avail, luasnip = pcall(require, "luasnip")
        if mini_snippets_avail and mini_snippets.session.get(false) then
          mini_snippets.session.jump("next")
          return
        elseif luasnip_avail and luasnip.locally_jumpable(1) then
          luasnip.jump(1)
          return
        elseif vim.snippet and vim.snippet.active({ direction = 1 }) then
          vim.schedule(function() vim.snippet.jump(1) end)
          return
        end
        if vim.g.ai_accept and vim.g.ai_accept() then return end
        fallback()
      end, { "i", "s" })
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        local mini_snippets_avail, mini_snippets = pcall(require, "mini.snippets")
        local luasnip_avail, luasnip = pcall(require, "luasnip")
        if mini_snippets_avail and mini_snippets.session.get(false) then
          mini_snippets.session.jump("prev")
          return
        elseif luasnip_avail and luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
          return
        elseif vim.snippet and vim.snippet.active({ direction = -1 }) then
          vim.schedule(function() vim.snippet.jump(-1) end)
          return
        end
        fallback()
      end, { "i", "s" })
    end,
  },

  -- ==================== Core Plugins ====================

  -- Obsidian integration
  {
    "obsidian-nvim/obsidian.nvim",
    event = { "BufReadPre  */LifeOS/*.md" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "hrsh7th/nvim-cmp", optional = true },
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["gf"] = {
                function()
                  if require("obsidian").util.cursor_on_markdown_link() then
                    return "<Cmd>ObsidianFollowLink<CR>"
                  else
                    return "gf"
                  end
                end,
                desc = "Obsidian Follow Link",
              },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      local astrocore = require("astrocore")
      return astrocore.extend_tbl(opts, {
        dir = "~/LifeOS",
        use_advanced_uri = true,
        finder = (astrocore.is_available("snacks.pick") and "snacks.pick")
          or (astrocore.is_available("telescope.nvim") and "telescope.nvim")
          or (astrocore.is_available("fzf-lua") and "fzf-lua")
          or (astrocore.is_available("mini.pick") and "mini.pick"),
        templates = {
          subdir = "templates",
          date_format = "%Y-%m-%d-%a",
          time_format = "%H:%M",
        },
        daily_notes = { folder = "daily" },
        completion = {
          nvim_cmp = astrocore.is_available("nvim-cmp"),
          blink = astrocore.is_available("blink"),
        },
        note_frontmatter_func = function(note)
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }
          if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
        follow_url_func = vim.ui.open,
      })
    end,
  },

  -- Snacks.nvim with animations and dashboard
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animate = {
        enabled = true,
        fps = 60,
        easing = "outQuad",
      },
      scroll = {
        enabled = true,
        animate = { duration = { step = 15, total = 250 } },
      },
      indent = {
        enabled = true,
        animate = {
          enabled = true,
          style = "out",
          easing = "linear",
          duration = { step = 20, total = 500 },
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      dashboard = { enabled = true },
      win = { enabled = true },
    },
  },

  -- AstroCore extensions: auto-restore sessions + custom mappings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        restore_session = {
          {
            event = "VimEnter",
            desc = "Restore previous directory session if neovim opened with no arguments",
            nested = true,
            callback = function()
              if vim.fn.argc(-1) == 0 then
                require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
              end
            end,
          },
        },
      },
      mappings = {
        n = {
          ["<Space>f0"] = { "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian Vault" },
        },
      },
    },
  },

  -- ==================== Disabled Plugins (uncomment to enable) ====================

  -- Disable better-escape
  { "max397574/better-escape.nvim", enabled = false },

  -- GitHub Copilot (disabled by default)
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "BufReadPost",
  --   opts = {
  --     suggestion = {
  --       keymap = { accept = false }, -- handled by completion engine
  --     },
  --   },
  --   specs = {
  --     {
  --       "AstroNvim/astrocore",
  --       opts = {
  --         options = {
  --           g = {
  --             ai_accept = function()
  --               if require("copilot.suggestion").is_visible() then
  --                 require("copilot.suggestion").accept()
  --                 return true
  --               end
  --             end,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },

  -- Input method auto-switching (disabled by default)
  -- {
  --   "keaising/im-select.nvim",
  --   config = function()
  --     require("im_select").setup({
  --       default_im_select = "keyboard-us",
  --       default_command = "fcitx5-remote",
  --       set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
  --       set_previous_events = { "InsertEnter" },
  --       keep_quiet_on_no_binary = false,
  --       async_switch_im = true,
  --     })
  --   end,
  -- },
}
