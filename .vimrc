" ==========================================================
" File Name:    .vimrc
" Author:       pixelmuerto
" Version:      0.1
" Last Change:  2009-03-02 14:04:19
" ==========================================================
syntax on
:set background=dark
":set backspace=eol,start,indent

filetype plugin on
filetype on

""taglist
"TlistToggle

""resaltar busqueda
":set hls

""correccion ortografia, [s ]s z= zg 
""desde vim 7
"augroup filetypedetect
"au BufNewFile,BufRead *.txt set spell
"au BufNewFile,BufRead *.tex set spell
"augroup END
set spelllang=es

""metodo de folding
:set fdm=marker
"Completar con tab{{{1
function! CleverTab()
	let col = col('.') - 1
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$' || strpart( getline('.'),col-1,col) =~ '\s' || !col
    return "\<Tab>"
  else
    return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

"}}}1

nmap ,v :tabnew ~/.vimrc<CR>
nmap ,s :so ~/.vimrc<cr>

"moverse entre <++> 
nnoremap <c-j> /<++><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<++><cr>c/+>/e<cr>

" Templates + manual snippets {{{1
function! LoadTemplate(extension)
	silent! :execute '0r ~/.vim/templates/'. a:extension. '.tpl'
	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim'
endfunction

"function! LoadSnippets(extension)
"	silent! :execute 'source ~/.vim/templates/'. a:extension. '.snippets.vim' 
"endfunction
""templates y snippets en base a la extension
:autocmd BufNewFile * silent! call LoadTemplate('%:e')
":autocmd BufRead,BufNewFile * silent! call LoadSnippets('%:e')
"}}}1
""autoindent y smartindent
:set ai
":set si
set tabstop=2 ""numero de espacios por un tab
set sw=3 ""numero de espacios por indent

"usar los 256 colores
:set t_Co=256 
colorscheme xoria256
":colorscheme desert256
":colorscheme calmar256
"numero de linea y color
:hi LineNr ctermfg=darkgray ctermbg=black 
:set nu
":set cursorline 
":hi CursorLine cterm=NONE ctermbg=236

""guardar y abrir ultima session {{{1
function! SaveSession()
	execute 'mksession! ~/.vim/sessions/session.vim'
endfunction
function! LoadSession()
	if argc() == 0
		execute 'source ~/.vim/sessions/session.vim'
	endif
endfunction
autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()
"}}}1
""limpiar la terminal al salir de vim
autocmd VimLeave * !clear

autocmd FileType python set omnifunc=pythoncomplete#Complete

"""""redirigir salida de comando
"""manual 
":redir @a
":set all
":redir END
""@ap
"""por funcion a newtab
" TabMessage {{{1

function! TabMessage(cmd)
	set nonu
	redir => message
	silent execute a:cmd
	redir END
	set nu
	tabnew
	silent put=message
	set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" }}}1
