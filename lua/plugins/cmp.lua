return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Conecta el motor de autocompletado con tu LSP
    "hrsh7th/cmp-buffer",   -- Sugiere palabras que ya están escritas en el archivo
    "hrsh7th/cmp-path",     -- Sugiere rutas de carpetas y archivos de tu PC
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      -- Neovim 0.10+ tiene soporte nativo para expandir fragmentos de código (snippets).
      -- cmp necesita saber cómo manejarlos.
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      
      -- Por defecto, cmp aparece automáticamente al escribir. 
      -- Aquí configuramos las teclas para movernos por ese menú emergente.
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Subir en la lista con Ctrl+k
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Bajar en la lista con Ctrl+j
        ["<C-Space>"] = cmp.mapping.complete(),     -- Forzar que aparezca el menú si lo cerraste
        ["<C-e>"] = cmp.mapping.abort(),            -- Cerrar el menú sin elegir nada
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Presionar Enter para aceptar la sugerencia
      }),
      
      -- Aquí le decimos de dónde sacar las palabras, ordenadas por prioridad
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Prioridad 1: Sugerencias inteligentes de Lua o Python
        { name = "buffer" },   -- Prioridad 2: Palabras del propio archivo
        { name = "path" },     -- Prioridad 3: Rutas de archivos
      }),
      
      -- Pequeño detalle visual para que el menú tenga bordes
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    })
  end,
}

