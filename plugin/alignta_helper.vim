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
let g:alignta_helper_enable_default =
      \ extend(get(g:, 'alignta_helper_enable_default', {}),
      \ {
      \   'braces': 1,
      \   'jabraces': 1,
      \   'codes': 1,
      \}, 'keep')

" setup default configs {{{
if g:alignta_helper_enable_default.braces
  call alignta_helper#setup('opts', {
  \ 'parens'            : '<<  \V\[()]',
  \ 'parens-no-margin'  : '<<0 \V\[()]',
  \ 'brackets'          : '<<  \V\[{}]',
  \ 'brackets-no-margin': '<<0 \V\[{}]',
  \ 'braces'            : '<<  \V\[\[\]]',
  \ 'braces-no-margin'  : '<<0 \V\[\[\]]',
  \ 'angles'            : '<<  \V\[<>]',
  \ 'angles-no-margin'  : '<<0 \V\[<>]',
  \})
  call alignta_helper#setup('keys', {
  \ 'parens'            : ['b', '('],
  \ 'parens-no-margin'  : ['<C-b>', ')'],
  \ 'brackets'          : ['B', '{'],
  \ 'brackets-no-margin': ['}'],
  \ 'braces'            : ['r', '['],
  \ 'braces-no-margin'  : ['<C-r>', ']'],
  \ 'angles'            : ['a', '<'],
  \ 'angles-no-margin'  : ['<C-a>', '>'],
  \})
endif
if g:alignta_helper_enable_default.jabraces
  call alignta_helper#setup('opts', {
  \ 'jabraces-parens'           : '<<0 \V\[\uFF08\uFF09]',
  \ 'jabraces-brackets'         : '<<0 \V\[\uFF5B\uFF5D]',
  \ 'jabraces-braces'           : '<<0 \V\[\uFF3B\uFF3D]',
  \ 'jabraces-angles'           : '<<0 \V\[\uFF1C\uFF1E]',
  \ 'jabraces-double-angles'    : '<<0 \V\[\u226A\u226B]',
  \ 'jabraces-kakko'            : '<<0 \V\[\u300C\u300D]',
  \ 'jabraces-double-kakko'     : '<<0 \V\[\u300E\u300F]',
  \ 'jabraces-yama-kakko'       : '<<0 \V\[\u3008\u3009]',
  \ 'jabraces-double-yama-kakko': '<<0 \V\[\u300A\u300B]',
  \ 'jabraces-kikkou-kakko'     : '<<0 \V\[\u3014\u3015]',
  \ 'jabraces-sumi-kakko'       : '<<0 \V\[\u3010\u3011]',
  \})
  call alignta_helper#setup('keys', {
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
endif
if g:alignta_helper_enable_default.codes
  call alignta_helper#setup('opts', {
  \ 'spaces'           : '<<0 \ ',
  \ 'tabs'             : '<<0 \t',
  \ 'blanks'           : '<<0 \V\[\ \t]',
  \ 'double-quotes'    : '<< "',
  \ 'single-quotes'    : '<< ''',
  \ 'back-quotes'      : '<< `',
  \ 'commas'           : '<< ,',
  \ 'periods'          : '<< .',
  \ 'puncts'           : '<< \V\[,.]',
  \ 'leaders'          : '<< \V\[\u2026]',
  \ 'colons'           : '<< :',
  \ 'semicolons'       : '<< ;',
  \ 'pluses'           : '<< +',
  \ 'hyphenminuses'    : '<< -',
  \ 'equals'           : '<< =',
  \ 'ampersands'       : '<< &',
  \ 'pipes'            : '<< <Bar>',
  \ 'question-marks'   : '<< ?',
  \ 'exclamation-marks': '<< !',
  \ 'slashs'           : '<< /',
  \ 'back-slashs'      : '<< \',
  \ 'carets'           : '<< ^',
  \ 'tildes'           : '<< ~',
  \ 'number-signs'     : '<< #',
  \ 'dollar-signs'     : '<< $',
  \ 'percent-signs'    : '<< @',
  \ 'at-signs'         : '<< %',
  \ 'stars'            : '<< *',
  \ 'underscores'      : '<< _',
  \})
  call alignta_helper#setup('keys', {
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
endif
" }}}

" mappings
nnoremap <silent> <Plug>(alignta_helper_map) :<C-u>call alignta_helper#map('n')<CR>
xnoremap <silent> <Plug>(alignta_helper_map) :<C-u>call alignta_helper#map('x')<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
