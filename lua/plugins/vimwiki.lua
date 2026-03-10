return {
  "vimwiki/vimwiki",
  config = function()
    vim.g.vimwiki_list = {{
      path = vim.fn.expand("~\\notas"),
      syntax = "markdown",
      ext = ".md",
    }}
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_markdown_link_ext = 1
    vim.g.vimwiki_url_maxsave = 0
  end,
}

