
" ------------------------------------------------------------------------
"  Plugin: Todo.txt-vim
" ------------------------------------------------------------------------
" activar el autocompletado de proyectos y contextos
au filetype todo setlocal omnifunc=todo#Complete
" Auto completar proyectos
au filetype todo imap <buffer> + +<C-X><C-O>
" Auto completar contextos
au filetype todo imap <buffer> @ @<C-X><C-O>

