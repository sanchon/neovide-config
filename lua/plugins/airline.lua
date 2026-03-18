return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin"
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true
      },
      sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
      }
    })
  end,
}
