" https://codekoalas.com/blog/setting-neovim-javascript-development

" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin()

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'scrooloose/nerdtree'

" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" https://hackernoon.com/5-vim-plugins-i-cant-live-without-for-javascript-development-f7e98f98e8d5
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" BACKUP: Plug 'neomake/neomake', { 'on': 'Neomake' }
Plug 'neomake/neomake'
Plug 'ludovicchabant/vim-gutentags'

"Javascript Plugins
Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

"Typescript Plugins
"Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"Plug 'Quramy/tsuquyomi'
"Plug 'mhartington/deoplete-typescript'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
" call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" https://github.com/Shougo/deoplete.nvim/blob/master/doc/deoplete.txt
" 			It is the deprecated option.
" 			Please use |deoplete#custom#source()| instead.
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:deoplete#sources#tss#javascript_support = 1
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_auto_open = 1
let g:tsuquyomi_disable_quickfix = 1
" linting and syntax checking
" let g:neomake_javascript_enabled_makers = ['eslint']

let g:gutentags_enabled = 1

""" for deoplete to work, each project needs a basic config like so:
""" {
"""  "compilerOptions": {
"""    "target": "ES6"
"""  },
"""  "exclude": [
"""    "node_modules"
"""  ]
"""}

" for additional benefits, we run neomake on every save
autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {
            \ 'text': '?',
            \ 'texthl': 'WarningMsg',
            \ }

let g:neomake_error_sign = {
            \ 'text': 'X',
            \ 'texthl': 'ErrorMsg',
            \ }


"""""""""""""""""""""""""""""""" NVIM SETTINGS """""""""""""""""""""""""""""""""
set number

" Tab settings / Space settings
set tabstop=4      " tabs have a width of 4
set softtabstop=4  " set number of colums for tab to 4
set shiftwidth=4   " indents have width of 4
set expandtab      " expand TABs to spaces
set smarttab       " insert indents at beginning of line

" Tab/Space settings - Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab

  " configuration files
  autocmd BufRead,BufNewFile .babelrc setlocal ts=2 sts=2 sw=2 expandtab smartindent
  autocmd BufRead,BufNewFile package.json setlocal ts=2 sts=2 sw=2 expandtab smartindent

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Syntax for different file types
  autocmd BufNewFile,BufRead *.ejs set filetype=html

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " smart indent for C-style programming languages
  """ :set cindent
endif

" run NERDTree on startup.  'wincmd p' goes to previous window
autocmd VimEnter *.html NERDTree | wincmd p
autocmd VimEnter *.css NERDTree | wincmd p
autocmd VimEnter *.js NERDTree | wincmd p

" remember cursor position for next time
autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel -ib")

" highlight cursor: `cursorcolumn` `cuc`, `cursorline` `cul`
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorcolumn
set cursorline
hi CursorColumn ctermbg=0
hi CursorLine cterm=NONE ctermbg=0

" Inivisible settings
set list           " show invisible
set listchars=tab:▸\ ,eol:¬     " use textmate's 'invisible' settings
" Invisible character colors
highlight NonText guifg=#555555
highlight SpecialKey guifg=#555555

" fold settings
setlocal foldmethod=syntax
" # of folding columns to display on the side
set foldcolumn=2
" folding
nnoremap <space> za
" jump over folded lines with { }
set foldopen-=block
" Save and load fold settings automatically
" Reference: http://vim-users.jp/2009/10/hack84/  (seems defunct)
" Reference: http://dotfiles.org/~tsukkee/.vimrc
" Don't save options.
set viewoptions-=options
augroup vimrc
    autocmd BufWritePost *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufRead *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
augroup END

""""""""""""""""""""""""""""""" REMAP NVIM KEYS """"""""""""""""""""""""""""""""

" omnicomplete
inoremap <c-space> <c-x><c-o>

" better movement
nnoremap h <bs>
vnoremap h <bs>
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap l <space>
vnoremap l <space>
nnoremap 0 g0
vnoremap 0 g0
nnoremap $ g$
vnoremap $ g$
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
nnoremap <a-j> 3j
nnoremap <a-k> 3k
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

" better middle-of-line command
nnoremap gm :call cursor(0, len(getline('.'))/2)<cr>

" enter key
nnoremap <cr> I<cr><esc><leader>

" backspace
nnoremap <bs> i<bs><esc>l

" copy to clipboard
nnoremap <leader>y <s-v>"+y
vnoremap <leader>y "+y
" paste from clipboard
nnoremap <leader>v "+p

" save
nnoremap cc :w<cr>
nnoremap <c-s> :exe 'w'<cr>
inoremap <c-s> <esc>:w<cr>a

" remove all trailing Whitespaces & return cursor position
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr><C-o>

" turn off search highlight
nnoremap <leader>o :nohlsearch<cr>
" keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" switch windows
noremap <leader>j <c-w>j
noremap <leader>k <c-w>k
noremap <leader>h <c-w>h
noremap <leader>l <c-w>l
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
" resize windows
nnoremap <c-left> :vertical resize -1<cr>
nnoremap <c-down> :resize +1<cr>
nnoremap <c-up> :resize -1<cr>
nnoremap <c-right> :vertical resize +1<cr>

" close current buffer
" https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window#8585343
nnoremap <leader>bd :b#<bar>bd#<CR>:bn<CR>:bp<CR>
nnoremap <leader>bq :bp<bar>sp<bar>bn<bar>bd<CR>

" output execution of current file onto screen
nnoremap <leader>r :read !node %<cr>

" command-line movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

""
" TODO: set the following only for Javascript

    " automatically close parenthesis, brackets, curly brackets, single quotes, double quotes, and backticks
    inoremap ( ()<left>
    inoremap (<cr> (<cr>)<esc>O
    inoremap [ []<left>
    inoremap [<cr> [<cr>]<esc>O
    inoremap { {}<left>
    inoremap {<cr> {<cr>}<esc>O

    " https://stackoverflow.com/questions/10097022/skip-over-closing-parentheses-in-vim
    inoremap <expr> ) SkipClosingParentheses()
    function! SkipClosingParentheses()
        let line = getline('.')
        let current_char = line[col('.')-1]

        "Ignore EOL
        if col('.') == col('$')
            return ")"
        end

        return stridx(')', current_char) == -1 ? ")" : "\<Right>"
    endfunction

    inoremap <expr> ] SkipClosingBracket()
    function! SkipClosingBracket()
        let line = getline('.')
        let current_char = line[col('.')-1]

        "Ignore EOL
        if col('.') == col('$')
            return "]"
        end

        return stridx(']', current_char) == -1 ? "]" : "\<Right>"
    endfunction

    inoremap <expr> } SkipClosingCurlyBracket()
    function! SkipClosingCurlyBracket()
        let line = getline('.')
        let current_char = line[col('.')-1]

        "Ignore EOL
        if col('.') == col('$')
            return "}"
        end

        return stridx('}', current_char) == -1 ? "}" : "\<Right>"
    endfunction

    inoremap <expr> ' SkipClosingSingleQuote()
    function! SkipClosingSingleQuote()
        let line = getline('.')
        let current_char = line[col('.')-1]

        "Ignore EOL
        if col('.') == col('$')
            return "''\<Left>"
        end

        return stridx("'", current_char) == -1 ? "''\<Left>" : "\<Right>"
    endfunction

    inoremap <expr> " SkipClosingDoubleQuote()
    function! SkipClosingDoubleQuote()
        let line = getline('.')
        let current_char = line[col('.')-1]

        "Ignore EOL
        if col('.') == col('$')
            return "\"\"\<left>"
        end

        return stridx('"', current_char) == -1 ? "\"\"\<left>" : "\<Right>"
    endfunction

    inoremap <expr> ` SkipClosingBacktick()
    function! SkipClosingBacktick()
        let line = getline('.')
        let current_char = line[col('.')-1]

        "Ignore EOL
        if col('.') == col('$')
            return "``\<Left>"
        end

        return stridx("`", current_char) == -1 ? "``\<Left>" : "\<Right>"
    endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""" BOTTOM """""""""""""""""""""""""""""""""""""
