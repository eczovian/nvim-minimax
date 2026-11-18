Config.later(
  function()
    vim.pack.add { Config.gh 'lewis6991/gitsigns.nvim' }
    require('gitsigns').setup { }
end
)
