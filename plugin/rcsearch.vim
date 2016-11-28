exec expand("rubyfile <sfile>:p:h/rcsearch.rb")
" Searches for a pattern that will also match the reverse complement of the
" given sequence
function! Rcsearch(seq)
  ruby <<EOF
    seq = VIM::evaluate('a:seq')
    pattern = BioVim.rcsearch(seq)
    VIM.command("let pattern = \'#{pattern}\'")
EOF
  if pattern != '0' 
    let @/ = pattern
    normal! n
  else
    echom "Invalid sequence - please use only GATCN."
  endif
endfunction

command -nargs=1 Biorc :call Rcsearch(<f-args>)

" Replaces the selected text (by movement or visual character or line) with
" its reverse complement
function! GetSelection(type)
  if a:type ==# 'v'
    execute "normal! `<v`>d"
  elseif a:type ==# 'V'
    execute "normal! `<V`>d"
"  Visual block not supported - doesn't really make sense for DNA anyway.
  elseif a:type ==# ''
    echom "Only visual character and line modes are supported"
    return
  elseif a:type ==# 'char'
    execute "normal! `[v`]d"
  else
    return
  endif
endfunction

function! RcOperator(type)
  let saved_register = @@
  call GetSelection(a:type)
  ruby <<EOF
  	seq = VIM::evaluate('@@')
  	VIM.command("let replacement = '#{BioVim.reverse_complement(seq)}'")
EOF
  if replacement != '0'
    "Checks whether the cursor is at the end of a line - if so, need to append
    "rather than replace
    if col(".") == col("$")-1
      execute "normal! a" . replacement
    else
      execute "normal! i" . replacement
    endif
  else
    " Replace the original text if the reverse complement failed
    execute "normal! P"
    echom "Reverse complement failed"
  endif
  let @@ = saved_register
endfunction
