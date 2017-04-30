# extendCR.vim

<blockquote class="imgur-embed-pub" lang="en" data-id="iHLx8CM"><a href="//imgur.com/iHLx8CM">How can I achieve this in Vim? (Automatic comment wrapping for comments not on their own line)</a></blockquote>

a micro plugin that extends `:h fo-table`'s `r` flag. there also is, as a side-effect of this being taken straight from my vimrc, an improvement when hitting `<CR>` on a line ending with `{`, that opens a new line with the closing bracket underneath (disable with `let no_split_braces_CR = 1`)

to enable:
`imap <CR> <PLUG>extendCR`
