require'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {'python','toml','json','javascript','c','cpp','typescript','lua','bash','vim','yaml'},
  
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
  
    -- List of parsers to ignore installing
    -- ignore_install = { "javascript" },

    -- 启用增量选择
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>',
        node_decremental = '<BS>',
        scope_incremental = '<TAB>',
      }
    },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
  
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
  
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    },
  }
