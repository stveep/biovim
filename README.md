##Using vim with DNA sequences

###Installation
Install using [Pathogen](https://github.com/tpope/vim-pathogen#installation).

```{bash}
cd ~/.vim/bundle
git clone https://github.com/stveep/biovim.git
```

###Reverse-complement sequence search
Run as follows, e.g. to search for NGG or CCN:
```{vim}
:Biorc NGG
```
Or in a vimscript, `:call Rcsearch("NGG")`; or from ruby `BioVim.rcsearch("NGG")`.

This works by converting the search string to a case-insensitive regexp containing the supplied and reverse-complemented string. Results will highlight if hlsearch is set (`:set hlsearch`).


###In-place reverse complementation

To activate this functionality, add the following lines to your `~/.vimrc` file. If you don't have a similar line setting up a 'leader' character, add this:

```{vim}
let mapleader = ","
```

This sets the 'leader' character to the comma (`,`). Add the following lines to map the reverse complement operator command to `R`.

```{vim}
nnoremap <leader>R :set operatorfunc=RcOperator<cr>g@
vnoremap <leader>R :<c-u>call RcOperator(visualmode())<cr>
```

Restart vim. Now you can reverse complement sequences either using conventional movement operations in vim (`hjkl`, `w`, `b` etc.):
```{vim}
,R<movement>
```
If your leader character is different, replace the comma with your custom leader. e.g. `,Rw` will reverse-complement up until the start of the next "word". `,R2l` will reverse-complement the following two bases.

Alternatively, select sequence using visual line (shift-v) or character (v) modes and type the `,R` command.

For more details see plugin/test directory.


