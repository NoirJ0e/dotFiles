return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = vim.tbl_deep_extend("force", opts.linters["markdownlint-cli2"] or {}, {
        args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint.jsonc", "--" },
      })
      return opts
    end,
  },
}
