fun! s:extendCR()
  if !search('\m\S','cnW',line('.'))
    let ws = &sw == 0 ? &ts : &sw
    let syn = synIDattr(synID(line('.'),col('.') - 1,0),'name')
    if syn =~? 'comment'
      let commst = matchstr(
            \ &commentstring, '\C^\s*\zs.*\S\ze\s*%s\s*$')
      let pretext = matchstr(getline('.'),'\C\V\^\.\{-}\ze'.escape(commst,'\'))
      if pretext =~ '\S'
        let vcol = strdisplaywidth(pretext)
        let align = matchstr(getline('.'),'\%'.(vcol+strlen(commst)+1).'v\s*')
        if vcol
          return "\<CR>0\<C-d>".repeat("\<TAB>",vcol/ws).repeat(' ',vcol%ws).commst.align
        endif
      endif
    elseif !get(b:,'no_split_braces_CR',get(g:,'no_split_braces_CR')) &&
          \ getline('.')[col('.')-2] == '{' && syn !~? 'string\|regex\|comment'
      return "\<CR>}\<C-o>O"
    endif
  endif
  return "\<CR>"
endfun
inoremap <silent><expr><PLUG>extendCR <SID>extendCR()
