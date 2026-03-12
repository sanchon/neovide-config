return {
  "vim-airline/vim-airline",
  dependencies = {
    "vim-airline/vim-airline-themes", -- Opcional, pero muy recomendado para cambiar estilos
  },
  init = function()
    -- Habilita el uso de fuentes Powerline
    vim.g.airline_powerline_fonts = 1

    -- (Opcional) Aquí puedes definir el tema que prefieras
    -- vim.g.airline_theme = 'dark'
    
    -- (Opcional) Mostrar los buffers abiertos en la parte superior
    vim.g['airline#extensions#tabline#enabled'] = 1
    vim.g["airline#extensions#branch#enabled"] = 1
    vim.g.airline_theme='catppuccin'
  end,
}

