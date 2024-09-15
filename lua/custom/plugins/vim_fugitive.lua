return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>G', '<cmd>Git<CR>')
  end,
}
