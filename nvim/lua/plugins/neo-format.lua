return {{
    "sbdchd/neoformat",
    cmd = "Neoformat",
    config = function()
      -- Create the autocommand group and the BufWritePre autocommand
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          vim.cmd "undojoin | Neoformat"
        end,
        group = vim.api.nvim_create_augroup("fmt", { clear = true }),
      })
    end,
}
}
