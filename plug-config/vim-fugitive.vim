
" ------------------------------------------------------------------------
"  Plugin: Fugitive (Git)
" ------------------------------------------------------------------------
command! GCP execute ':Git commit -m "cambios de ' .. strftime('%Y-%m-%d') ..'" | Git push'
