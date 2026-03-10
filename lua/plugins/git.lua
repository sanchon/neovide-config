return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      vim.cmd([[
        command! GCP execute ':Git commit -m "cambios de ' .. strftime('%Y-%m-%d') ..'" | Git push'
      ]])
    end,
  },
}

