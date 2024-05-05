local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = function()
    local null_ls = require 'null-ls'
    return {
      debug = true,
      sources = {
        null_ls.builtins.formatting.stylua,

        -- go
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.code_actions.impl,
        null_ls.builtins.code_actions.gomodifytags,
      },
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
