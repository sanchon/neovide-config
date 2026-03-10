-- Aspecto -------------------------------------------------------------------
vim.opt.guifont = "Fira Code:h11"
vim.opt.relativenumber = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  precedes = "«",
  extends = "»",
  eol = "¶",
  space = "·",
}
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false
vim.opt.wrap = false

-- Neovide --------------------------------------------------------------------
if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_cursor_animation_length = 0.04

  -- Font zoom
  vim.keymap.set("n", "<leader>+", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.1
  end, { silent = false })

  vim.keymap.set("n", "<leader>-", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.1
  end, { silent = false })

  vim.keymap.set("n", "<leader>0", function()
    vim.g.neovide_scale_factor = 1
  end, { silent = false })
end

-- Copias de seguridad --------------------------------------------------------
vim.opt.backupdir = vim.fn.expand("$HOME") .. "/.vim/temp//"
vim.opt.directory = vim.fn.expand("$HOME") .. "/.vim/temp//"
vim.opt.undodir = vim.fn.expand("$HOME") .. "/.vim/temp//"

-- Usabilidad -----------------------------------------------------------------
vim.opt.smartcase = true
vim.opt.autochdir = true
vim.opt.clipboard = "unnamed"

-- Gestión de buffers / teclas de función ------------------------------------
vim.opt.hidden = true

local map = vim.keymap.set

-- F5: refrescar
map({ "n", "i" }, "<F5>", function()
  vim.cmd.edit()
end, { silent = true })

-- F7: buffer anterior
map({ "n", "i" }, "<F7>", function()
  vim.cmd.bprevious()
end, { silent = true })

-- F8: buffer siguiente
map({ "n", "i" }, "<F8>", function()
  vim.cmd.bnext()
end, { silent = true })

-- F10: cerrar buffer
map({ "n", "i" }, "<F10>", function()
  vim.cmd.bdelete()
end, { silent = true })

-- Navegar por la ayuda
map("n", "<C-+>", "<C-]>", { noremap = true })

-- Tabs rápidos ---------------------------------------------------------------
map({ "n", "i" }, "<C-Tab>", function()
  vim.cmd.tabnext()
end, { silent = true })

map({ "n", "i" }, "<C-S-Tab>", function()
  vim.cmd.tabprevious()
end, { silent = true })

-- Copy/Paste estilo Windows --------------------------------------------------
if vim.fn.has("win32") == 1 then
  -- CTRL+V pega
  map("i", "<C-v>", '<esc>"*pa', { noremap = true })
  map("c", "<C-v>", "<C-r>*", { noremap = true })
  -- CTRL+X corta en visual
  map("v", "<C-x>", '"*d', { noremap = true })
  -- CTRL+C copia en visual
  map("v", "<C-c>", '"*y', { noremap = true })
end

-- Leader ---------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- FTP al host (netrw) --------------------------------------------------------
vim.g.netrw_ftp_cmd = "ftp -v -s:" .. vim.fn.expand("$HOME") .. "\\MACHINE.ftp"
vim.g.netrw_use_errorwindow = 0

vim.cmd([[
  command! -nargs=+ Host  e ftp://mvsp1/\'<args>\'
  command! -nargs=+ PLI   e ftp://mvsp1/'sys1.cage.fuentes(<args>)' | setlocal filetype=pli
  command! -nargs=+ INC   e ftp://mvsp1/'cage.maclib(<args>)'      | setlocal filetype=pli
  command! -nargs=+ JCL   e ftp://mvsp1/'sys1.cage.jcllib(<args>)' | setlocal filetype=jcl
  command! -nargs=+ JCLD  e ftp://mvsp1/'sys1.cage.jcllib(<args>)' | setlocal filetype=sh
  command! -nargs=+ FILE  e ftp://mvse1/'<args>'
]])

-- Calculadora ----------------------------------------------------------------
-- Mantengo el mapping original en Vimscript para que el comportamiento sea idéntico
vim.cmd([[
  vnoremap <Leader>c y:let @a = eval(substitute(@", '[\n\r\t ]', '', 'g')) <bar> redraw <bar> echo "Resultado en @a: " . @a<CR>
]])

-- Comando SqlIn --------------------------------------------------------------
vim.cmd([[
  command! SqlIn %s/\s\+$// | %s/.*/'&'/ | %s/\n/,/g | %s/,$// | normal! yy
]])

-- Plugins con lazy.nvim ------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
})

