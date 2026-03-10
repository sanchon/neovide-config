return {
  "dbeniamine/todo.txt-vim",
  config = function()
    local aug = vim.api.nvim_create_augroup("TodoTxtVim", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = aug,
      pattern = "todo",
      callback = function()
        vim.bo.omnifunc = "todo#Complete"
        vim.keymap.set("i", "+", "+<C-X><C-O>", { buffer = true })
        vim.keymap.set("i", "@", "@<C-X><C-O>", { buffer = true })
      end,
    })
  end,
}

