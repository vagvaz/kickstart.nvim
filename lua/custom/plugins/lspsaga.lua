return {
  {
    'nvimdev/lspsaga.nvim',
    event = 'VeryLazy',
    config = function()
      require('lspsaga').setup {
        ui = {
          border = 'rounded',
          code_action = '💡',
        },
        preview = {
          lines_above = 3,
          lines_below = 12,
        },
        code_action = {
          show_server_name = true,
        },
        rename = {
          in_select = false,
        },
        lightbulb = {
          enable = false,
          -- gitsigns has priority 6
          sign_priority = 8,
        },
      }
    end,
  },
}
