local add = vim.pack.add
-- Honorable mentions =========================================================

-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
--
-- You can use it like so:
Config.now_if_args(function()
  local servers = {
    angularls = {},
    ts_ls = {},

    helm_ls = {},
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = "auto",
      },
      hover = {
        documentation = true,
        references = true,
      },
    },

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
            path = { "lua/?.lua", "lua/?/init.lua" },
          },
          workspace = {
            checkThirdParty = false,
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },

    gitlab_ci_ls = {},
    gopls = {},
    marksman = {},
    clangd = {},
    cssls = {},
    zls = {},
    svelte = {},
    tailwindcss = {
      filetypes = {
        "svelte",
        "javascript",
        "typescript",
        "html",
      },
    },
    pylsp = {},
  }

  add({ Config.gh("neovim/nvim-lspconfig") })
  add({ Config.gh("mason-org/mason.nvim") })
  add({ Config.gh("mason-org/mason-lspconfig.nvim") })
  add({ Config.gh("WhoIsSethDaniel/mason-tool-installer.nvim") })

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require("mason").setup({
    -- Supply chain attack myself so mason stops crying when resolving server packages
    npm = {
      install_args = {"--min-release-age", "0"}
    }
  })

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsStartingInstall",
    callback = function()
      vim.schedule(function()
        print("mason-tool-installer is starting")
      end)
    end,
  })

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require("mason-lspconfig").setup({
    automatic_enable = true, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  })

  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end)
