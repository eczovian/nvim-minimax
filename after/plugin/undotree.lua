Config.later(
  function()
    vim.pack.add { 'https://github.com/mbbill/undotree' }
    vim.keymap.set('n', '<leader>ot', vim.cmd.UndotreeToggle, { desc = '[t]oggle Undotree' })
    vim.keymap.set('n', '<leader>ou', function()
      vim.cmd.UndotreeShow()
      vim.cmd.UndotreeFocus()
    end, { desc = '[O]pen [U]ndotree' })
  end
)
