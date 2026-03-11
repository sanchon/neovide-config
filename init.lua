-- Leader (definir antes de mappings que lo usen)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opciones: aspecto
vim.opt.guifont = "Fira Code:h11"
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false
vim.opt.listchars = {
  tab = "→ ", trail = "·", precedes = "«", extends = "»",
  eol = "¶", space = "·",
}

-- Opciones: copias de seguridad y usabilidad
local temp = vim.fn.expand("$HOME") .. "/.vim/temp//"
vim.opt.backupdir = temp
vim.opt.directory = temp
vim.opt.undodir = temp
vim.opt.smartcase = true
vim.opt.autochdir = true
vim.opt.clipboard = "unnamed"
vim.opt.hidden = true

-- Opciones: completado (cmdline / wildmenu)
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildoptions = { "pum" }
vim.opt.wildignorecase = true
vim.opt.pumheight = 15
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append("c")

-- Neovide
if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_cursor_animation_length = 0.04
  local function scale(delta)
    vim.g.neovide_scale_factor = math.max(0.1, (vim.g.neovide_scale_factor or 1) + delta)
  end
  local map = vim.keymap.set
  map("n", "<leader>+", function() scale(0.1) end, { silent = false })
  map("n", "<leader>-", function() scale(-0.1) end, { silent = false })
  map("n", "<leader>0", function() vim.g.neovide_scale_factor = 1 end, { silent = false })
end

-- Mappings: buffers y tabs
local map = vim.keymap.set
map("n", "<F5>", "<Cmd>e<CR>", { silent = true })
map("i", "<F5>", "<C-o>:e<CR>", { silent = true })
map("n", "<F7>", "<Cmd>bprevious<CR>", { silent = true })
map("i", "<F7>", "<C-o>:bprevious<CR>", { silent = true })
map("n", "<F8>", "<Cmd>bnext<CR>", { silent = true })
map("i", "<F8>", "<C-o>:bnext<CR>", { silent = true })
map("n", "<F10>", "<Cmd>bdelete<CR>", { silent = true })
map("i", "<F10>", "<C-o>:bdelete<CR>", { silent = true })
map("n", "<C-+>", "<C-]>", { noremap = true })
map("n", "<C-Tab>", "<Cmd>tabnext<CR>", { silent = true })
map("i", "<C-Tab>", "<C-o>:tabnext<CR>", { silent = true })
map("n", "<C-S-Tab>", "<Cmd>tabprevious<CR>", { silent = true })
map("i", "<C-S-Tab>", "<C-o>:tabprevious<CR>", { silent = true })

-- Copy/Paste estilo Windows
if vim.fn.has("win32") == 1 then
  map("i", "<C-v>", '<esc>"*pa', { noremap = true })
  map("c", "<C-v>", "<C-r>*", { noremap = true })
  map("v", "<C-x>", '"*d', { noremap = true })
  map("v", "<C-c>", '"*y', { noremap = true })
end

-- FTP (netrw) y comandos personalizados
vim.g.netrw_ftp_cmd = "ftp -v -s:" .. vim.fn.expand("$HOME") .. "\\MACHINE.ftp"
vim.g.netrw_use_errorwindow = 0
vim.cmd([[
  command! -nargs=+ Host  e ftp://mvsp1/\'<args>\'
  command! -nargs=+ PLI   e ftp://mvsp1/'sys1.cage.fuentes(<args>)' | setlocal filetype=pli
  command! -nargs=+ INC   e ftp://mvsp1/'cage.maclib(<args>)'      | setlocal filetype=pli
  "command! -nargs=+ JCL   e ftp://mvsp1/'sys1.cage.jcllib(<args>)' | setlocal filetype=jcl
  "command! -nargs=+ JCLD  e ftp://mvsp1/'sys1.cage.jcllib(<args>)' | setlocal filetype=sh
  command! -nargs=+ FILE  e ftp://mvse1/'<args>'
  vnoremap <Leader>c y:let @a = eval(substitute(@", '[\n\r\t ]', '', 'g')) <bar> redraw <bar> echo "Resultado en @a: " . @a<CR>
  command! SqlIn %s/\s\+$// | %s/.*/'&'/ | %s/\n/,/g | %s/,$// | normal! yy
]])

-- Nuevo comando JCL inteligente (Reemplaza a JCL y JCLD)
vim.api.nvim_create_user_command('JCL', function(opts)
  -- 1. Construir la ruta y abrir el archivo
  local filepath = "ftp://mvsp1/'sys1.cage.jcllib(" .. opts.args .. ")'"
  vim.cmd("edit " .. filepath)

  -- 2. Obtener la primera línea de forma segura
  local first_line = vim.fn.getline(1)

  -- 3. Analizar la primera línea (Shebang) asegurándonos de que es un string
  if type(first_line) == "string" and (first_line:match("^#!.*sh") or first_line:match("^#!.*bash")) then
    vim.bo.filetype = "sh"
    print("Detectado bash, aplicando filetype sh")
  else
    vim.bo.filetype = "jcl"
  end
end, { nargs = '+' })


-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ { import = "plugins" } })
