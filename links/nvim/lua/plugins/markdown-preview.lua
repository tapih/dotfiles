vim.cmd[[
function! OpenBrowser(url)
	if has('unix')
		exe '!open ' . a:url
	else
		exe '!xdg-open ' . a:url
	endif
endfunction]]

