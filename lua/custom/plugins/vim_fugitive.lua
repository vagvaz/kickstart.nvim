return {
  'tpope/vim-fugitive',
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>G', '<cmd>Git<CR>')
  end,
}
