exec expand("rubyfile <sfile>:p:h/rcsearch.rb")
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


function! RcOperator(type)
  let saved_register = @@
  if a:type ==# 'v'
    execute "normal! `<v`>d"
  elseif a:type ==# 'V'
    execute "normal! `<V`>d"
"  Visual block not supported - doesn't really make sense for DNA anyway.
"  elseif a:type ==# '^V'
"    execute "normal! `<^V`>d"
  elseif a:type ==# 'char'
    execute "normal! `[v`]d"
  else
    return
  endif
  ruby <<EOF
  	seq = VIM::evaluate('@@')
  	VIM.command("let replacement = '#{BioVim.reverse_complement(seq)}'")
EOF
  execute "normal! a" . replacement
  let @@ = saved_register
endfunction
