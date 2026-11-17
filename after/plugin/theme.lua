Config.now(
  function()
    vim.pack.add { 'https://github.com/catppuccin/nvim' }
    require('catppuccin').setup {}
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'catppuccin-mocha'
  end
)
