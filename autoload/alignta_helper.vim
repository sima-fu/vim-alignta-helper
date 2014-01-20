" File:        autoload/alignta-helper.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/
" Last Change: 2014-01-21.

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" s:alignta_args {{{
let s:alignta_args = {
\ 'parens'            : '<<  \V\[()]',
\ 'parens-no-margin'  : '<<0 \V\[()]',
\ 'brackets'          : '<<  \V\[{}]',
\ 'brackets-no-margin': '<<0 \V\[{}]',
\ 'braces'            : '<<  \V\[\[\]]',
\ 'braces-no-margin'  : '<<0 \V\[\[\]]',
\ 'angles'            : '<<  \V\[<>]',
\ 'angles-no-margin'  : '<<0 \V\[<>]',
\
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
\
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
\}
" }}}
function! s:map_plug(name)
  execute 'nnoremap <silent>'
        \ '<Plug>(alignta_helper_' . a:name . ')'
        \ ':<C-u>%Alignta ' . s:alignta_args[a:name] . '<CR>'
  execute 'xnoremap <silent>'
        \ '<Plug>(alignta_helper_' . a:name . ')'
        \ ':Alignta ' . s:alignta_args[a:name] . '<CR>'
endfunction

function! alignta_helper#init_mappings(do_mappings, motions)
  if a:do_mappings && g:alignta_helper_leader_key != ''
    for [name, defaultkeys] in items(a:motions)
      call s:map_plug(name)
      for key in defaultkeys
        execute 'nmap' g:alignta_helper_leader_key . key
            \ '<Plug>(alignta_helper_' . name . ')'
        execute 'xmap' g:alignta_helper_leader_key . key
            \ '<Plug>(alignta_helper_' . name . ')'
      endfor
    endfor
  else
    for [name, defaultkeys] in items(a:motions)
      call s:map_plug(name)
    endfor
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
