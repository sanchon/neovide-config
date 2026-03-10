-- Solo completado en búsqueda (/ y ?). Para comandos (:) se usa lo nativo:
-- wildmenu, wildmode y wildoptions (ver init.lua).
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer" },
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
    end,
  },
}

