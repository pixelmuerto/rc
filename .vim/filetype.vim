"para function CommentLine
"en modo visual presionar co : para comentar las lineas
au BufRead,BufNewFile *.inc,*.ihtml,*.html,*.tpl,*.class set filetype=php | let Comment="<!-- " | let EndComment=" -->"
au BufRead,BufNewFile *.sh,*.pl,*.tcl let Comment="#" | let EndComment=""
au BufRead,BufNewFile *.js let Comment="//" | let EndComment=""
au BufRead,BufNewFile *.cc,*.php,*.cpp let Comment="//" | let EndComment=""
au BufRead,BufNewFile *.c,*.h let Comment="/*" | let EndComment="*/"
au BufRead,BufNewFile *.css let Comment="/*" | let EndComment="*/"
