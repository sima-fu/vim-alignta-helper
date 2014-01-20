" File:        plugin/alignta-helper.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/
" Last Change: 2014-01-21.

scriptencoding utf-8

if exists('g:loaded_alignta_helper')
  finish
endif
let g:loaded_alignta_helper = 1

let s:save_cpo = &cpo
set cpo&vim

let g:alignta_helper_do_brace_mappings = get(g:, 'alignta_helper_do_brace_mappings', 1)
let g:alignta_helper_do_jabrace_mappings = get(g:, 'alignta_helper_do_jabrace_mappings', 1)
let g:alignta_helper_do_code_mappings = get(g:, 'alignta_helper_do_code_mappings', 1)
let g:alignta_helper_leader_key = get(g:, 'alignta_helper_leader_key', '')

call alignta_helper#init_mappings(g:alignta_helper_do_brace_mappings, {
\ 'parens'            : ['b', '(', ')'],
\ 'parens-no-margin'  : [''],
\ 'brackets'          : ['B', '{', '}'],
\ 'brackets-no-margin': [''],
\ 'braces'            : ['r', '[', ']'],
\ 'braces-no-margin'  : ['R'],
\ 'angles'            : ['a', '<', '>'],
\ 'angles-no-margin'  : ['A'],
\})

call alignta_helper#init_mappings(g:alignta_helper_do_jabrace_mappings, {
\ 'jabraces-parens'           : ['jb', 'j(', 'j)' ],
\ 'jabraces-brackets'         : ['jB', 'j{', 'j}' ],
\ 'jabraces-braces'           : ['jr', 'j[', 'j]' ],
\ 'jabraces-angles'           : ['ja', 'j<', 'j>' ],
\ 'jabraces-double-angles'    : ['jA'],
\ 'jabraces-kakko'            : ['jk'],
\ 'jabraces-double-kakko'     : ['jK'],
\ 'jabraces-yama-kakko'       : ['jy'],
\ 'jabraces-double-yama-kakko': ['jY'],
\ 'jabraces-kikkou-kakko'     : ['jt'],
\ 'jabraces-sumi-kakko'       : ['js'],
\})

call alignta_helper#init_mappings(g:alignta_helper_do_code_mappings, {
\ 'spaces'           : ['<Space>', 's'],
\ 'tabs'             : ['<Tab>', 't'],
\ 'blanks'           : ['S', 'T'],
\ 'double-quotes'    : ['"', 'd'],
\ 'single-quotes'    : ["'", 'q'],
\ 'back-quotes'      : ['`'],
\ 'commas'           : [',', 'c'],
\ 'periods'          : ['.'],
\ 'puncts'           : ['C'],
\ 'leaders'          : ['l'],
\ 'colons'           : [':'],
\ 'semicolons'       : [';'],
\ 'pluses'           : ['+'],
\ 'hyphenminuses'    : ['-'],
\ 'equals'           : ['=', 'e'],
\ 'ampersands'       : ['&'],
\ 'pipes'            : ['<Bar>', 'p'],
\ 'question-marks'   : ['?'],
\ 'exclamation-marks': ['!'],
\ 'slashs'           : ['/'],
\ 'back-slashs'      : ['\'],
\ 'carets'           : ['^'],
\ 'tildes'           : ['~'],
\ 'number-signs'     : ['#'],
\ 'dollar-signs'     : ['$'],
\ 'at-signs'         : ['@'],
\ 'percent-signs'    : ['%'],
\ 'stars'            : ['*'],
\ 'underscores'      : ['_'],
\})

let &cpo = s:save_cpo
unlet s:save_cpo
