let NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$' ]
let NERDTreeShowHidden = 1
" http://qiita.com/ymiyamae/items/3fa77d85163fb734b359
" ファイルの方にカーソルを向ける
" function! s:MoveToFileAtStart()
"   call feedkeys("\<Space>")
"   call feedkeys("\s")
"   call feedkeys("\l")
" endfunction

call dein#add('Xuyuanp/nerdtree-git-plugin')
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" augroup NERDTreeAutoCmds
"     autocmd!
"     autocmd VimEnter * NERDTree | call s:MoveToFileAtStart() " 起動時に開く
" augroup END

