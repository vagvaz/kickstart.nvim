return
{
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      config = true,
    },
    {
      "williamboman/mason-lspconfig.nvim",
    },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- Library paths can be absolute
          -- "~/projects/my-awesome-lib",
          -- Or relative, which means they will be resolved from the plugin dir.
          -- "lazy.nvim",
          -- It can also be a table with trigger words / mods
          -- Only load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          -- always load the LazyVim library
          -- "LazyVim",
          -- Only load the lazyvim library when the `LazyVim` global is found
          -- { path = "LazyVim", words = { "LazyVim" } },
          -- Load the wezterm types when the `wezterm` module is required
          -- Needs `justinsgithub/wezterm-types` to be installed
          -- { path = "wezterm-types", mods = { "wezterm" } },
          -- Load the xmake types when opening file named `xmake.lua`
          -- Needs `LelouchHe/xmake-luals-addon` to be installed
          -- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
        },
        -- always enable unless `vim.g.lazydev_enabled = false`
        -- This is the default
        -- enabled = function(root_dir)
        enabled = function()
          return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
        end,
        -- disable when a .luarc.json file is found
        -- enabled = function(root_dir)
        --   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
        -- end,
      },
    },
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local servers = {
      lua_ls = {},
      pyright = {},
      gopls = {},
      clangd = {},
      -- bash_language_server= {},
      -- cmake_language_sever= {},

    }
    require('mason').setup {}
    require('mason-lspconfig').setup {}

    for server, _ in pairs(servers) do
      require('lspconfig')[server].setup { capabilities = capabilities }
    end
    -- Setup keymaps
    vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format() end, { desc = '[F]ormat file' })
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client == 'clangd' then return end
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
      end,
    })
    -- require("lspconfig").lua_ls.setup {}
    -- require("lspconfig").pyright.setup {}
    -- require("lspconfig").gopls.setup {}
  end,
}
