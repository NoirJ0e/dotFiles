-- lua/plugins/tailwindcss.lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
            local bufnr = vim.uri_to_bufnr(result.uri)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            if filename:match("%.v[wh]%.tsx$") then
              result.diagnostics = vim.tbl_filter(function(d)
                return d.code ~= "suggestCanonicalClasses"
              end, result.diagnostics)
            end
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
          end,
        },
      },
    },
  },
}
