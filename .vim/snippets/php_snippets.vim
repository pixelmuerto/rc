"========================================================
" File Name: php_snippets.vim
" Author: JPA
" Version: 0.1
" Last Change: 2009-02-20 15:00:23
" =======================================================
" s:define_snippets {{{1

function! s:define_snippets()
	DefineSnippet php <?php<{}>?>
	""" snippets html
	DefineSnippet div         <div <{}>><CR><{}><CR></div><CR><{}>
	DefineSnippet ul         	<ul><CR><{}><CR></ul><CR><{}>
endfunction

" }}}1
" s:set_compiler_info {{{1

function! s:set_compiler_info()
		
endfunction

" }}}1
if exists('loaded_cca')
	 filetype indent on
	 let b:{cca_filetype_ext_var} = 'php'
	 let b:{cca_locale_tag_var} = { "start": "<{", "end"  : "}\>", "cmd"  : ":"}

	 call s:define_snippets()
endif

if exists('loaded_ctk')
	 let b:{ctk_filetype_ext_var} = 'php'
	 call s:set_compiler_info() 
endif

delfunc s:define_snippets
delfunc s:set_compiler_info
