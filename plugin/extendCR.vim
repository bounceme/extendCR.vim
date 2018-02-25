if exists('g:loaded_extendCR')
	fini
en
let g:loaded_extendCR=1

fu s:d()
	if !search('\m.','n',line('.'))
		let s=["synIDattr(synID(line('.'),col('.')-1,0),'name')"]
		if !get(b:,'no_extend_comment_CR',get(g:,'no_extend_comment_CR'))&&match(map(s,'string(eval(v:val))'),'\ccomment')+1
			let c=matchstr(&cms,'\C^\s*\zs.*\S\ze\s*%s\s*$')
			if len(c)&&search('\V\C\^\.\{-}\zs'.escape(c,'\'),'b',line('.'))
				if c=~'^\(.\)\1*$'
					let c=matchstr(getline('.')[col('.')-1:],'\V\^'.escape(c,'\').'\+')
				en
				let w=&sw?&sw:&ts
				let v=virtcol('.')-1
				let a=matchstr(getline('.'),'\%'.(v+len(c)+1).'v\s*')
				if !search('\m\S','bn',line('.'))
					if &fo=~#'r'
						retu "\<CR>\<C-u>0\<C-d>".repeat("\<C-y>",col('.')+len(c)-1).a
					en
				el
					retu "\<CR>0\<C-d>".repeat("\<TAB>",v/w).repeat(' ',v%w).c.a
				en
			en
		elsei !get(b:,'no_split_braces_CR',get(g:,'no_split_braces_CR'))&&getline('.')[col('.')-2]=='{'&&eval(s[0])!~?'string\|regex\|comment'
			retu "\<CR>}\<C-o>O"
		en
	en
	retu "\<CR>"
endf
ino <silent><expr><PLUG>extendCR <SID>d()
