return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = false,
        theme = 'iceberg',
      },
    })
  end
}
