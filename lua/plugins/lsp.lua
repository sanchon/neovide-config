return {
  -- Solo necesitamos Mason para gestionar la descarga del servidor en Windows
  "williamboman/mason.nvim",
  config = function()
    -- 1. Inicializamos Mason
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- 2. Usamos la API NATIVA de Neovim para configurar el LSP
    -- Definimos las reglas para el servidor de Lua
    vim.lsp.config.lua_ls = {
      -- Mason se encarga de que este comando esté disponible en el PATH de Neovim
      cmd = { "lua-language-server" }, 
      filetypes = { "lua" },
      root_markers = { ".git", ".luarc.json", "init.lua" },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- 3. Habilitamos el servidor
    vim.lsp.enable("lua_ls")

    -- ==========================================
    -- 3. ¡NUEVO! CONFIGURACIÓN PARA PYTHON
    -- ==========================================
    vim.lsp.config.pyright = {
      -- El comando que Mason hace disponible para ejecutar el servidor
      cmd = { "pyright-langserver", "--stdio" },
      -- Solo se activará cuando abras archivos de Python
      filetypes = { "python" },
      -- Archivos que le indican al LSP dónde está la raíz de tu proyecto
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    }
    -- Habilitamos el servidor de Python
    vim.lsp.enable("pyright")


    -- ==========================================
    -- 4. CONFIGURACIÓN PARA MARKDOWN
    -- ==========================================
    vim.lsp.config.marksman = {
      -- El comando para iniciar el servidor
      cmd = { "marksman", "server" },
      -- Se activará cuando abras archivos .md
      filetypes = { "markdown", "markdown.mdx" },
      -- Define la raíz del proyecto (útil si tienes una carpeta de notas conectadas)
      root_markers = { ".git", ".marksman.toml" },
    }
    -- Habilitamos el servidor de Markdown
    vim.lsp.enable("marksman")



  end,
}
