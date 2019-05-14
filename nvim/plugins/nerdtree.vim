let NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$' ]
let NERDTreeShowHidden = 1
" http://qiita.com/ymiyamae/items/3fa77d85163fb734b359
" ファイルの方にカーソルを向ける
" function! s:MoveToFileAtStart()
"   call feedkeys("\<Space>")
"   call feedkeys("\s")
"   call feedkeys("\l")
" endfunction
let g:NERDTreeWinPos = "right"

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

" auto close nerdtree when close window and there is only one window at that time
augroup NERDTreeAutoClose
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

let NERDTreeIgnore=['\~$']

