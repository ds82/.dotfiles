" install plug.vim if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin(stdpath('data') . '/plugged')

" lua helper functions
Plug 'nvim-lua/plenary.nvim'

" does not work right now :/
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


Plug 'Quramy/vim-js-pretty-template'
Plug 'maxmellon/vim-jsx-pretty'
"
" Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tveskag/nvim-blame-line'

Plug 'tpope/vim-surround'
" Plug 'lukas-reineke/indent-blankline.nvim'

" Nerdtree
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'

" nvim-tree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Better navigation between open files
Plug 'ThePrimeagen/harpoon'

" TS
" Plug 'Quramy/tsuquyomi'
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'

" Text objects
" Plug 'kana/vim-textobj-function'
" Plug 'haya14busa/vim-textobj-function-syntax'
" Plug 'thinca/vim-textobj-function-javascript'

Plug 'mhinz/vim-startify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" vim wiki
Plug 'vimwiki/vimwiki'

" Themes
" Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
" Plug 'joshdick/onedark.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'dracula/vim', { 'as': 'dracula' }

" rust
Plug 'rust-lang/rust.vim'


" misc
Plug 'tpope/vim-unimpaired'
Plug 'voldikss/vim-floaterm'


call plug#end()

lua << EOF
  require('init')
EOF


" startify
let g:startify_bookmarks = [ '~/.config/nvim/init.vim', '~/ownCloud/raidbot.md', '~/code/titan-web', '~/code/firmware', '~/code' ]
let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

function! PlugLoaded(name)
  return (
      \ has_key(g:plugs, a:name) &&
      \ isdirectory(g:plugs[a:name].dir) &&
      \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction


" fix clipboard
set clipboard=unnamed

set termguicolors
syntax enable
set number
set relativenumber


" Theme config
" colorscheme OceanicNext
let g:gruvbox_contrast_dark=1
colorscheme gruvbox
" colorscheme onedark

" packadd! dracula
" colorscheme dracula

hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
"
" airline
" let g:airline_theme='oceanicnext'
" let g:airline_theme='dracula'
let g:airline_theme='gruvbox'
" let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
set showtabline=2

" colorcolumn
set colorcolumn=80,100
set cursorline
" set colorcolumn to 60,8o when commiting with git
au FileType gitcommit set colorcolumn=60,80

" tab config
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" splits
set splitbelow
set splitright

" coc config
let g:coc_node_path = $DEFAULT_NODE 

" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']

if filereadable(expand("~/.config/nvim/coc.vim"))
  so ~/.config/nvim/coc.vim
endif


" fzf
let g:fzf_preview_window = []
let g:fzf_layout = { 'down': '20%' }

" NERDTree
" let NERDTreeShowBookmarks=1
" let NERDTreeShowHidden=1
" let NERDTreeShowLineNumbers=0
" let g:NERDCommentWholeLinesInVMode=2
" let g:NERDRemoveExtraSpaces=1
" let NERDTreeChDirMode=2


" functions
function! CloseWindowOrKillBuffer() "{{{
	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

	" never bdelete a nerd tree
	if matchstr(expand("%"), 'NERD') == 'NERD'
		wincmd c
		return
	endif

	if number_of_windows_to_this_buffer > 1
		wincmd c
	else
		bdelete
	endif
endfunction "}}}


" indent blankline setup
let g:indent_blankline_filetype_exclude = ['help', 'nerdtree']
let g:indent_blankline_buftype_exclude = ['terminal', 'nerdtree']

" filetypes
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" keybindings
let mapleader=","

" utils
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>
nnoremap <silent><leader>,1 :edit ~/.config/nvim/init.vim<CR>

" files, nerdtree, etc
" silent! nmap <F2> :NERDTreeToggle<CR>
" nnoremap<C-\> :NERDTreeFind<CR>

nnoremap <F2> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <C-\> :NvimTreeFindFile<CR>


nnoremap <leader>f :Files<CR>
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>
nnoremap vv <C-W>v
nnoremap ss <C-W>s

noremap <C-l> <C-w>l
nmap <leader>k :let @+ = expand("%")<CR>

" coc
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> coc#refresh()

" remap increment/decrement to avoid tmux collision
noremap <A-a> <C-a>
noremap <A-x> <C-x>

" tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" git gutter
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 1

" figutive
nmap <leader>gs :G<CR>

" buffer navigation with TAB/SHIFT-TAB in normal mode
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" save with sudo
cmap w!! w !sudo tee %

" copy filepath to clipboard
nmap <leader>k :let @+ = expand("%")<cr>

" search word under cursor with ag
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" fix register access to a,o,u in osx with german umlaut-funktion
nnoremap ä "a
nnoremap ö "o
nnoremap ü "u

" harpoon
nnoremap <Leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap g1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap g2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap g3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap g4 :lua require("harpoon.ui").nav_file(4)<CR>

" nvim-tree
let g:nvim_tree_disable_window_picker = 1

" auto source vim config on change
au! BufWritePost $MYVIMRC source %

let g:nvim_tree_disable_window_picker = 1
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "json",
    "yaml",
    "html",
    "scss"
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF

" vim wiki
let g:vimwiki_list = [{'path': '~/ownCloud/vimwiki'}]

" rust
let g:rustfmt_autosave = 1

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

" floatterm
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_next   = '<F4>'

let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1


" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader><Leader> :ZoomToggle<CR>



