
"--------------------------------------------------------------------------
" aspecto
"--------------------------------------------------------------------------
set guifont=Fira\ Code:h11
set relativenumber
set listchars=tab:→\ ,trail:·,precedes:«,extends:»,eol:¶,space:·
set foldmethod=syntax
set nofoldenable
set nowrap

if exists("g:neovide")
  let g:neovide_remember_window_size = v:true
  let g:neovide_scale_factor=1.0
  let g:neovide_cursor_animation_length=0.04
endif



"--------------------------------------------------------------------------
" copias de seguridad controladitas
"--------------------------------------------------------------------------
set backupdir=$HOME/.vim/temp//
set directory=$HOME/.vim/temp//
set undodir=$HOME/.vim/temp//



"--------------------------------------------------------------------------
" usabilidad
"--------------------------------------------------------------------------
set smartcase
set autochdir                                "cambia el directorio actual al del fichero abierto
set clipboard=unnamed                            "para que se use el registro *


"teclas de funcion: gestion de buffers
"----------------------------------
set hidden                                       "no me importa que haya buffers ocultos

map <F5> :e<CR>               " F5:refresh
imap <F5> <Esc>:e<CR>
map <F7> :bp<CR>              " F7:anterior
imap <F7> <Esc>:bp<CR>
map <F8> :bn<CR>              " F8:siguiente
imap <F8> <Esc>:bn<CR>
map <F10> :bd<CR>             " F10:cerrar
imap <F10> <Esc>:bd<CR>

"para navegar por la ayuda:
nnoremap <C-+> <C-]>


"para cambiar de tab rápidamente
"-------------------------------
map <C-Tab> :tabnext<CR>
imap <C-Tab> <Esc>:tabnext<CR>
map <C-S-Tab> :tabprevious<CR>
imap <C-S-Tab> <Esc>:tabprevious<CR>

if has("win32")                                  "en Windows... copy-paste con ctrl-c y ctrl-v
        " ---- Windows Like Copy-Paste keys ----
        " CTRL-v is paste
        inoremap <C-v> <esc>"*pa
        cnoremap <C-v> <C-r>*
        " CTRL-x is cut (in visual mode only)
        vnoremap <C-x> "*d
        " CTRL-c is copy (in visual mode only)
        vnoremap <C-c> "*y
    " endif
endif


"  El espacio es el leader
" ------------------------------------------------------------------------
let mapleader=" "
let maplocalleader=" "



"  Fontzoom de Neovide
" ------------------------------------------------------------------------
if exists("g:neovide")
  lua vim.api.nvim_set_keymap("n", "<leader>+", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.2<CR>", { silent = false })
  lua vim.api.nvim_set_keymap("n", "<leader>-", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.2<CR>", { silent = false })
  lua vim.api.nvim_set_keymap("n", "<leader>0", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = false })
endif







"--------------------------------------------------------------------------
" FTP AL HOST
"
" " para hacer FTP lo lógico es esto:
" let g:netrw_ftpmode="ascii"
"
" usuario y password de ftp en fichero aparte, en windows. En otros sistemas
" mejor usar .netrc
let g:netrw_ftp_cmd= "ftp -v -s:" . $HOME . "\\MACHINE.ftp"
" al hacer logon con el fichero salen mensajes en la ventana de mensajes... me
" la cargo:
let g:netrw_use_errorwindow=0
" 
" FTPs al host: así me ahorro el mvsp1 y las comillas al inicio y al final:
command! -nargs=+ Host e ftp://mvsp1/\'<args>\'
command! -nargs=+ PLI e ftp://mvsp1/'sys1.cage.fuentes(<args>)' | setlocal filetype=pli
command! -nargs=+ INC e ftp://mvsp1/'cage.maclib(<args>)' | setlocal filetype=pli
command! -nargs=+ JCL e ftp://mvsp1/'sys1.cage.jcllib(<args>)' | setlocal filetype=jcl
command! -nargs=+ JCLD e ftp://mvsp1/'sys1.cage.jcllib(<args>)' | setlocal filetype=sh
command! -nargs=+ FILE e ftp://mvse1/'<args>'
"--------------------------------------------------------------------------





command! SqlIn %s/\s\+$// | %s/.*/'&'/ | %s/\n/,/g | %s/,$// | normal! yy


"--------------------------------------------------------------------------
" PLUGINS
"--------------------------------------------------------------------------
"
call plug#begin()
Plug 'ouuan/vim-plug-config'
Plug 'sanchon/misChuletas'
Plug 'vim-airline/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'sanchon/PLI-Tools'
Plug 'davdai01/jcl.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'yegappan/mru'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'dbeniamine/todo.txt-vim'
Plug 'vimwiki/vimwiki'
Plug 'wfxr/minimap.vim'
call plug#end()





