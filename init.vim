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

" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" https://hackernoon.com/5-vim-plugins-i-cant-live-without-for-javascript-development-f7e98f98e8d5
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'neomake/neomake', { 'on': 'Neomake' }
Plug 'ludovicchabant/vim-gutentags'

"Javascript Plugins
Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

"Typescript Plugins
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Quramy/tsuquyomi'
Plug 'mhartington/deoplete-typescript'

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

" enter key
nnoremap <cr> I<cr><esc><leader>

" copy to clipboard
nnoremap <leader>y <s-v>"+y
vnoremap <leader>y "+y
" paste from clipboard
nnoremap <leader>v "+p

" save
nnoremap cc :w<cr>
nnoremap <c-s> :exe 'w'<cr>
inoremap <c-s> <esc>:w<cr>a

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""" BOTTOM """""""""""""""""""""""""""""""""""""
