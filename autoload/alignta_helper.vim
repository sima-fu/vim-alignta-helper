" File:        autoload/alignta_helper.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

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
    for [optname, keylist] in items(g:alignta_helper_keys)
      if !has_key(g:alignta_helper_opts, optname)
        throw 'The option name of "' . optname . '" is not found in g:alignta_helper_opts.'
      endif
      for key in keylist
        let key = s:unescape(key)
        let _t = self.table
        let i = 0
        while i < strlen(key)
          let char = key[i]
          if char == "\<Esc>" || char == "\<C-c>"
            " <Esc> と <C-c> は入力を中止するために予約済み
            throw 'The chars of "<Esc>" and "<C-c>" are not available in g:alignta_helper_keys.'
          endif
          let isLastchar = i == strlen(key) - 1
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
          let i += 1
        endwhile
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
      let opt = g:alignta_helper_opts[_t[char]]
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
