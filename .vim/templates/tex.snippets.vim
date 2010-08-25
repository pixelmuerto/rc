" por defecto es {{{,}}} cambiado para ajustarse a snipmate
set foldmarker=(fold),(end)
set wrap
" para guardar y compilar el tex actual
nmap ,m :w <BAR> !pdflatex %<CR>
