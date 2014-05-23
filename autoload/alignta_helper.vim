" File:        autoload/alignta_helper.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" opts {{{
let s:opts = extend(g:alignta_helper_opts, {
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
\}, 'keep')
" }}}
" keys {{{
let s:keys = extend(g:alignta_helper_keys, {
\ 'parens'            : ['b', '('],
\ 'parens-no-margin'  : ['<C-b>', ')'],
\ 'brackets'          : ['B', '{'],
\ 'brackets-no-margin': ['}'],
\ 'braces'            : ['r', '['],
\ 'braces-no-margin'  : ['<C-r>', ']'],
\ 'angles'            : ['a', '<'],
\ 'angles-no-margin'  : ['<C-a>', '>'],
\
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
\
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
\}, 'keep')
" }}}

function! s:unescape(key) " {{{
  let key = split(a:key, '\(<[^<>]\+>\|.\)\zs')
  call map(key, 'v:val =~ "^<.*>$" ? eval(''"\'' . v:val . ''"'') : v:val')
  return join(key, '')
endfunction " }}}
function! s:getchar() " {{{
  let char = getchar()
  return type(char) == type(0) ? nr2char(char) : char
endfunction " }}}

let s:helper = {}
function! s:helper.buildTable() " {{{
  let self.table = {}
  try
    for [optname, keylist] in items(s:keys)
      if !has_key(s:opts, optname)
        throw 'The option name of "' . optname . '" is not found in g:alignta_helper_opts.'
      endif
      for key in keylist
        let key = s:unescape(key)
        let _t = self.table
        for char in split(key, '\zs')
          if char == "\<Esc>" || char == "\<C-c>"
            " <Esc> と <C-c> は入力を中止するために予約済み
            throw 'The chars of "<Esc>" and "<C-c>" are not available in g:alignta_helper_keys.'
          endif
          let isLastchar = (key =~ '\V' . escape(char, '\') . '\$')
          if has_key(_t, char)
            if type(_t[char]) == type('') || isLastchar
              throw 'The key of "' . key . '" has overlapped in g:alignta_helper_keys.'
            endif
          else
            if isLastchar
              " 設定して次のキーへ
              let _t[char] = optname
              break
            endif
            let _t[char] = {}
          endif
          let _t = _t[char]
        endfor
      endfor
    endfor
  catch
    unlet self.table
    throw v:exception
  endtry
endfunction " }}}
function! s:helper.getOpt() " {{{
  if !has_key(self, 'table') | call self.buildTable() | endif
  let opt = ''
  let [_t, char] = [self.table, s:getchar()]
  while has_key(_t, char)
    if char == "\<Esc>" || char == "\<C-c>"
      " <Esc> と <C-c> は入力を中止するために予約済み
      break
    endif
    if type(_t[char]) == type('')
      " 設定を取得
      let opt = s:opts[_t[char]]
      break
    else
      let [_t, char] = [_t[char], s:getchar()]
    endif
  endwhile
  return opt
endfunction " }}}

function! alignta_helper#map(mode) " {{{
  try
    let opt = s:helper.getOpt()
    if opt != ''
      execute printf('%sAlignta %s',
            \ {'n': '%', 'x': "'<,'>"}[a:mode],
            \ opt
            \)
    endif
  catch
    echohl ErrorMsg | echomsg 'alignta_helper:' v:exception | echohl None
  endtry
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo
