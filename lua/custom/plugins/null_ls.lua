return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  ft = { 'python' },
  opts = function()
    local null_ls = require 'null-ls'
    local opts = {
      sources = {
        null_ls.builtins.diagnostics.mypy,
      },
    }
    return opts
    -- return require '.null-ls'
  end,
}
