vim.cmd [[
  augroup MyAutoCmd
    autocmd!
  augroup END

  " Remove trailing spaces for all files
  autocmd BufWritePre * :call RemoveCommentTrailingSpaces()
  function! RemoveCommentTrailingSpaces() abort
    let l:extension = expand('%:e')
    if 'md' != l:extension
      if 'rs' == l:extension
        let l:rustdoc_regex = '\(\/\/\/\|\/\/!\)'
        let l:cursor_pos = getpos('.')
        execute ':v/' . l:rustdoc_regex . '/s/\s\+$//ge'
        call setpos('.', l:cursor_pos)
      else
        execute ':%s/\s\+$//ge'
      endif
    endif
  endfunction

  " Set filetype-specific indentation and options
  autocmd Filetype rst setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 smartindent
  autocmd Filetype markdown setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

  " Set filetype-specific syntax and spell check
  autocmd BufNewFile,BufRead *.gp  set syntax=gnuplot
  autocmd BufNewFile,BufRead *.tex set syntax=plaintex
  autocmd BufNewFile,BufRead *.tex set spell
  autocmd BufNewFile,BufRead *.md  set spell
  autocmd BufNewFile,BufRead *.txt set spell
  autocmd BufNewFile,BufRead *.rst set spell
  autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

  " Move cursor to where it was
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Set global variables
  let g:indentLine_fileTypeExclude = ['tex']
  let g:tex_flavor = "latex"
  let fortran_free_source=1
  let c_no_curly_error=1
]]
