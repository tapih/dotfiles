let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['filename'], ['fugitive', 'gitgutter', 'ale'],
        \   ],
        \   'right': [
        \     ['lineinfo'], ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component_function': {
        \   'mode': 'MyMode',
        \   'filename': 'MyFileName',
        \   'fugitive': 'MyFugitive',
        \   'ale': 'ALEGetStatusLine',
        \   'gitgutter': 'MyGitGutter',
        \   'fileformat': 'MyFileFormat',
        \   'fileencoding': 'MyFileEncoding',
        \   'filetype': 'MyFileType',
        \   'charcode': 'MyCharCode',
        \ },
        \ 'separator': {'left': '>>', 'right': '|'},
        \ 'subseparator': {'left': '|', 'right': '|'}
        \ }

function! MyModified()
  return &ft =~ 'help\|nerdtree\|gundo\|tagbar\|terminal' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadOnly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '|' : ''
endfunction

function! MyFileName()
  let fname = expand('%p:t')
  return  &ft == 'nerdtree' ? 'NERDTree' :
        \ &ft == 'tagbar' ? 'TagBar' :
        \ &ft == 'denite' ? denite#get_status_string() :
        \ ('' != MyReadOnly() ? MyReadOnly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'help\|nerdtree\|gundo\|tagbar\|terminal' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? _ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ':',
        \ g:gitgutter_sign_modified . ':',
        \ g:gitgutter_sign_removed . ':'
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! MyFileFormat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFileType()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileEncoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

" http//github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction


