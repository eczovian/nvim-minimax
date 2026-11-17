Config.later(
  function()
    vim.pack.add {
      'https://github.com/JetBrains/intellij-lsp.nvim',
      'https://github.com/mfussenegger/nvim-dap',
    }

    require('intellij-lsp').setup { accept_eula = true, colorscheme = false, server_download = true }
  end
)

