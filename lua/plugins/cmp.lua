return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")

      -- Cmdline : (comandos + rutas)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Búsqueda / y ? (usa el buffer actual)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
  -- Fuente buffer requerida para / y ?
  { "hrsh7th/cmp-buffer", event = "CmdlineEnter" },
}

