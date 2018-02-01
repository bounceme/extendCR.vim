if exists('g:loaded_extendCR')
	finish
endif
let g:loaded_extendCR = 1

fun! s:extendCR()
	if !search('\m.','n',line('.'))
		let syn = ["synIDattr(synID(line('.'),col('.')-1,0),'name')"]
		if !get(b:,'no_extend_comment_CR',get(g:,'no_extend_comment_CR')) &&
					\ match(map(syn,'string(eval(v:val))'),'\ccomment') != -1
			let commst = matchstr(&commentstring, '\C^\s*\zs.*\S\ze\s*%s\s*$')
			if len(commst) && search('\V\C\^\.\{-}\zs'.escape(commst,'\'),'b',line('.'))
				let ws = &sw ? &sw : &ts
				let vcol = virtcol('.') - 1
				let align = matchstr(getline('.'),'\%'.(vcol+len(commst)+1).'v\s*')
				if !search('\m\S','bn',line('.'))
					if &fo =~# 'r'
						return "\<CR>\<C-u>0\<C-d>".repeat("\<C-y>",col('.')+len(commst)-1).align
					endif
				else
					return "\<CR>0\<C-d>".repeat("\<TAB>",vcol/ws).repeat(' ',vcol%ws).commst.align
				endif
			endif
		elseif !get(b:,'no_split_braces_CR',get(g:,'no_split_braces_CR')) &&
					\ getline('.')[col('.')-2] == '{' && eval(syn[0]) !~? 'string\|regex\|comment'
			return "\<CR>}\<C-o>O"
		endif
	endif
	return "\<CR>"
endfun
inoremap <silent><expr><PLUG>extendCR <SID>extendCR()
