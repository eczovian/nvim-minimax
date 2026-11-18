vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy '+',
    ['*'] = require('vim.ui.clipboard.osc52').copy '*',
  },
  paste = {
    ['+'] = function(reg)
      return function(lines) end
    end,
    ['*'] = function(reg)
      return function(lines) end
    end,
  },
}
