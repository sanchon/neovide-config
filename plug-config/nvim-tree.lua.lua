-- Archivo: lua/arbolito.lua
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
  },
  sync_root_with_cwd = true, -- Sincroniza la raíz del árbol con el directorio actual de Neovim
  respect_buf_cwd = true,    -- Respeta el directorio del buffer actual (imprescindible por tu 'autochdir')
  update_focused_file = {
    enable = true,           -- Resalta automáticamente el archivo que estás editando
    update_root = true,      -- Cambia la raíz del árbol si abres un archivo de otro directorio
  }, renderer = {
    group_empty = true,
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})

vim.keymap.set('n', '<Leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
