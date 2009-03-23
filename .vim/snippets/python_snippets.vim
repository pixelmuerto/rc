" ==========================================================
" File Name:    python_snippets.vim
" Author:       JPA
" Version:      0.1
" Last Change:  2009-02-26 15:09:19
" ==========================================================
" s:define_snippets	 {{{1

function! s:define_snippets	()
	 DefineSnippet def <esc>0d$a# <{function_name:}> {{{<C-R>=foldlevel(line('.'))<cr><cr><bs><bs><cr>def <{function_name:}>(<{}>):<cr><TAB><{}><CR><BS># }}}<C-R>=foldlevel(line('.'))<cr>
	 DefineSnippet for for <{}> in <{}>:<cr><tab><{}><cr><bs><{}>
	 DefineSnippet if if <{}> :<cr><tab><{}><cr><bs><{}>
	 DefineSnippet except try:<cr><tab><{}><cr><bs>except <{}> :<cr><tab><{}><cr><bs><{}>
	 DefineSnippet finally try:<cr><tab><{}><cr><bs>finally:<cr><tab><{}><cr><bs><{}>
endfunction

" }}}1
" s:set_compiler_info {{{1

function! s:set_compiler_info()

endfunction

" }}}1

if exists('loaded_cca')
    filetype indent on
    " for {{{ and }}} support
    set fdm=marker

    let b:{cca_filetype_ext_var} = 'python'
    let b:{cca_locale_tag_var} = { "start": "<{", "end"  : "}>", "cmd"  : ":"}

    call s:define_snippets()
endif

if exists('loaded_ctk')
    let b:{ctk_filetype_ext_var} = 'python'
    call s:set_compiler_info()
endif

delfunc s:define_snippets
delfunc s:set_compiler_info
" vim: ft=python:fdm=marker:ts=4:sts=4:sw=4:nu:et:sta:ai
