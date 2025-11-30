return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'c',
        'rust',
        'typescript',
        'python',
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = { enable = true },
    })
  end,
}
