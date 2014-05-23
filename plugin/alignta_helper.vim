" File:        plugin/alignta_helper.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/

scriptencoding utf-8

if exists('g:loaded_alignta_helper')
  finish
endif
let g:loaded_alignta_helper = 1

let s:save_cpo = &cpo
set cpo&vim

let g:alignta_helper_opts = get(g:, 'alignta_helper_opts', {})
let g:alignta_helper_keys = get(g:, 'alignta_helper_keys', {})

nnoremap <silent> <Plug>(alignta_helper_map) :<C-u>call alignta_helper#map('n')<CR>
xnoremap <silent> <Plug>(alignta_helper_map) :<C-u>call alignta_helper#map('x')<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
