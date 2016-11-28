exec expand("rubyfile <sfile>:p:h/luckyblat.rb")

function! YankSelection(type)
  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'V'
    execute "normal! `<V`>y"
"  Visual block not supported - doesn't really make sense for DNA anyway.
  elseif a:type ==# ''
    echom "Only visual character and line modes are supported"
    return
  elseif a:type ==# 'char'
    execute "normal! `[v`]y"
  else
    return
  endif
endfunction

function! LuckyBlat(type)
  call YankSelection(a:type)
  echom 'BLAT: ' . @@
  ruby <<EOF
    seq = VIM::evaluate('@@')
    VIM.command("echom 'Position: #{ LuckyBlat.new(seq).blat }'")
EOF
endfunction

function! LuckyBlatURL(type)
  call YankSelection(a:type)
  echom 'BLAT: ' . @@
  ruby <<EOF
    seq = VIM::evaluate('@@')
    VIM.command("exec '!open #{ LuckyBlat.new(seq).blat(:url) }'")
EOF
endfunction
