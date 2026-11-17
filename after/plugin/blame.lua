Config.later(
  function()
    vim.pack.add {
      'https://github.com/FabijanZulj/blame.nvim',
    }
    require('blame').setup {}
    vim.keymap.set('n',
    '<leader>ogb',
    function()
      vim.cmd 'BlameToggle'
    end,
    { desc = 'Open git blame' })

  end
)

