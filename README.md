*Reverse-complement sequence search in Vim.*

Install using [Pathogen][https://github.com/tpope/vim-pathogen#installation].

```{bash}
cd ~/.vim/bundle
git clone https://github.com/stveep/biovim.git
```

Run as follows, e.g. to search for NGG or CCN:
```{vim}
:Biorc NGG
```
Or in a vimscript, `:call Rcsearch("NGG")`; or from ruby `BioVim.rcsearch("NGG")`.

This works by converting the search string to a case-insensitive regexp containing the supplied and reverse-complemented string. Results will highlight if hlsearch is set (`:set hlsearch`).

For more details see plugin/test directory.


