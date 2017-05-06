if exists('g:loaded_extendCR')
  finish
endif
let g:loaded_extendCR = 1

fun! s:extendCR()
  if col('.') == col('$')
    let ws = &sw?&sw:&ts?&ts:1
    let syn = synIDattr(synID(line('.'),col('.') - 1,0),'name')
    if !get(b:,'no_extend_comment_CR',get(g:,'no_extend_comment_CR')) && syn =~? 'comment'
      let commst = matchstr(
            \ &commentstring, '\C^\s*\zs.*\S\ze\s*%s\s*$')
      if strlen(commst) && search('\V\C\^\.\{-}\zs'.escape(commst,'\'),'bW',line('.')) &&
            \ search('\m\S','bnW',line('.'))
        let vcol = virtcol('.') - 1
        let align = matchstr(getline('.'),'\%'.(vcol+strlen(commst)+1).'v\s*')
        return "\<CR>0\<C-d>".repeat("\<TAB>",vcol/ws).repeat(' ',vcol%ws).commst.align
      endif
    elseif !get(b:,'no_split_braces_CR',get(g:,'no_split_braces_CR')) &&
          \ getline('.')[col('.')-2] == '{' && syn !~? 'string\|regex\|comment'
      return "\<CR>}\<C-o>O"
    endif
  endif
  return "\<CR>"
endfun
inoremap <silent><expr><PLUG>extendCR <SID>extendCR()
