"/ vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"      _   _   __  __   __    __  _  ___  __   _   _  _  __ __
"     | | | | /  \ \ \_/ /   |  \| || __|/__\ | \ / || ||  V  |
"     | 'V' || /\ | > , <    | | ' || _|| \/ |`\ V /'| || \_/ |
"     !_/ \_!|_||_|/_/ \_\   |_|\__||___|\__/   \_/  |_||_| |_|
"
" Inspired by:
"   - https://github.com/kristijanhusak/neovim-config/blob/master/init.vim
"   - https://github.com/wincent/wincent
"
" Should look up into:
"   - https://github.com/joker1007/dotfiles/blob/master/vimrc
"   - https://github.com/alexlafroscia/dotfiles/blob/master/nvim/init.vim  for js / html
"   - https://github.com/Leotomas/dotfiles-that-fly/blob/master/vim/vimrc for js / html

scriptencoding utf-8
set encoding=utf-8   " is the default in neovim though
let mapleader=","

" Plugins {{{

let s:url_plug = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
let s:path_to_plug_file = $HOME . "/.local/share/nvim/site/autoload/plug.vim"
if !filereadable(s:path_to_plug_file)
  echo "Downloading Plug (plugin manager) ..."
  call system("curl -fLo " . s:path_to_plug_file . " --create-dirs " . s:url_plug)
endif

let s:plugin_dir = $HOME . "/.config/nvim/plugged"
if !isdirectory(s:plugin_dir)
  echo "Creating " . s:plugin_dir
  call system("mkdir -p " . s:plugin_dir)
endif

call plug#begin(s:plugin_dir)

" System {{{
  Plug 'christoomey/vim-tmux-navigator' " tmux navigation in love with vim
  Plug 'jgdavey/tslime.vim'             " Send command from vim to a running tmux session
  Plug 'scrooloose/nerdcommenter'       " easy comments

  " Tpope is awesome
  Plug 'tpope/vim-surround'        " change surrounding easily
  Plug 'tpope/vim-repeat'          " better action repeat for vim-surround with .
  Plug 'tpope/vim-eunuch'          " sugar for the UNIX shell commands
  Plug 'tpope/vim-fugitive'        " Git wrapper for vim

  Plug 'Konfekt/FastFold', { 'branch': 'master' } " update folds only when needed, otherwise folds slowdown vim
  Plug 'zhimsel/vim-stay'                " adds automated view session creation and restoration whenever editing a buffer
  Plug 'junegunn/vim-easy-align'         " easy alignment, better than tabularize
  Plug 'AndrewRadev/splitjoin.vim'       " easy split join on whole paragraph
  Plug 'wellle/targets.vim'              " text object for parenthesis & more !
  Plug 'michaeljsmith/vim-indent-object' " text object based on indentation levels.

  Plug 'janko/vim-test'            " test at the speed of light

  "Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}     " visualize undo tree
  "Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}     " browsing the tags, require ctags
  "Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " file tree

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " Fuzzy Finder
  Plug 'junegunn/fzf.vim'

  Plug 'justinmk/vim-sneak'  " minimalist motion with 2 keys

  Plug 'vim-scripts/loremipsum'         " dummy text generator (:Loremipsum [number of words])
  " Plug 'terryma/vim-multiple-cursors'   " nice plugin for multiple cursors
"}}}

" User Interface {{{
  Plug 'mhinz/vim-startify'        " fancy start screen for Vim
  Plug 'kshenoy/vim-signature'     " toggle display marks
  Plug 'itchyny/lightline.vim'     " light status line
  Plug 'josa42/vim-lightline-coc'  " coc diagnostic in statusline
  Plug 'ap/vim-buftabline'         " buffer line
  Plug 'Yggdroot/indentLine'       " thin indent line
  Plug 'rhysd/conflict-marker.vim' " conflict markers for vimdiff
  Plug 'luochen1990/rainbow'       " embed parenthesis colors
  Plug 'airblade/vim-gitgutter'    " column sign for git changes
  Plug 'wincent/loupe'             " better focus on current highlight search

  Plug 'morhetz/gruvbox'           " best colorscheme ever

  " nerd font need to be installed, see https://github.com/ryanoasis/nerd-fonts#font-installation
  " > sudo pacman -S ttf-nerd-fonts-symbols
  " > brew tap caskroom/fonts && brew cask install font-hack-nerd-font
  Plug 'ryanoasis/vim-devicons'  " nice icons added
" }}}

" Completion {{{
  Plug 'ervandew/supertab' " use <Tab> for all your insert completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'Shougo/neco-vim', {'for': 'vim'}
  Plug 'neoclide/coc-neco', {'for': 'vim'}
  " }}}

" Every
  "Plug 'sheerun/vim-polyglot'  " Solid syntax and indentation support

" Python
  Plug 'tmhedberg/SimpylFold', {'for': 'python'}  " better folds
  Plug 'python-mode/python-mode', {'for': 'python'}

" Golang
  Plug 'fatih/vim-go', {'for': 'go'}

" markdown & rst
  Plug 'dhruvasagar/vim-table-mode'                    " to easily create tables.
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }           " Distraction-free writing in Vim
  Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " Dim paragraphs above and below the active paragraph.

" Terraform
  Plug 'hashivim/vim-terraform', { 'for': 'terraform' }

" Latex
  Plug 'lervag/vimtex', { 'for': 'tex' }

call plug#end()
"}}}

" Plugin configuration {{{

" Easy Align, used to tabularize map:
vmap <leader>t <Plug>(EasyAlign)

" Goyo
let g:goyo_width = 120
nmap <leader>go :Goyo <cr>

" limelight
let g:limelight_conceal_ctermfg=244

" indentLine
let g:indentLine_color_gui = '#343d46'  " indent line color got indentLine plugin
let g:indentLine_fileTypeExclude = ['json', 'startify', 'markdown', 'vim', 'tex']

" rainbow
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" lightline {{{
" https://github.com/itchyny/lightline.vim/issues/87

let g:lightline = { 'colorscheme': 'gruvbox'}

" Register the components:
let g:lightline.component_expand = {
  \   'coc_warnings': 'lightline#coc#warnings',
  \   'coc_errors': 'lightline#coc#errors',
  \   'coc_ok': 'lightline#coc#ok',
  \   'status': 'lightline#coc#status',
  \ }

" Set color to the components:
let g:lightline.component_type = {
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ }

let g:lightline_custom_layout = {
    \ 'left': [ [ 'mode', 'paste', 'coc_errors', 'coc_warnings', 'coc_ok' ],
    \           [ 'readonly', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'absolutepath', 'filetype' ] ] }

let g:lightline.inactive = lightline_custom_layout
let g:lightline.active = lightline_custom_layout

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" }}}

" fzf {{{
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \                         : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \                 <bang>0)

function! FzfOmniFiles()
    let is_git = system('git status')
    if v:shell_error
        execute 'Files'
    else
        execute 'GFiles'
    endif
endfunction

function! AgOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    execute 'Ag'
  else
    execute 'GGrep'
  endif
endfunction

nmap <leader>a :call AgOmniFiles()<CR>
nmap <leader>c :BCommits<CR>
nmap <leader>f :Tags<CR>
nmap <leader>p :call FzfOmniFiles()<CR>
nmap <C-p> :call FzfOmniFiles()<CR>
nmap <leader>b :Buffers<CR>

" fzf
" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" }}}

" SuperTab {{{
let g:SuperTabMappingForward = '<S-Tab>'
let g:SuperTabMappingBackward = '<Tab>'
" }}}

" SimpylFold & FastFold {{{
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1
let g:SimpylFold_fold_import = 0
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
"}}}

" NERDCommenter {{{
let g:ft = ''

" VueJS handle:
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
" }}}

"{{{ coc.nvim
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> å <Plug>(coc-diagnostic-prev)
nmap <silent> ß <Plug>(coc-diagnostic-next)
imap <silent> å <esc><Plug>(coc-diagnostic-prev)
imap <silent> ß <esc><Plug>(coc-diagnostic-next)

" Format
nmap <silent> <leader>m <Plug>(coc-format)
nmap <silent> <leader>. :CocCommand python.sortImports<cr>

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Aliases
" Command aliases or abbrevations
function! CommandAlias(aliasname, target)
  " :aliasname => :target  (only applicable at the beginning of the command line)
  exec printf('cnoreabbrev <expr> %s ', a:aliasname)
    \ .printf('((getcmdtype() ==# ":" && getcmdline() ==# "%s") ? ', a:aliasname)
    \ .printf('("%s") : ("%s"))', escape(a:target, '"'), escape(a:aliasname, '"'))
endfunction
call CommandAlias('CC', 'CocCommand')

let g:coc_global_extensions = [
      \ "coc-python",
      \ "coc-pairs",
      \ "coc-json",
      \ "coc-yaml",
      \ "coc-prettier",
      \ "coc-css",
      \ "coc-html",
      \ "coc-eslint",
      \ "coc-tslint",
      \ "coc-tsserver",
      \ "coc-ultisnips",
      \ "coc-tailwindcss",
      \ "coc-vetur"]
"}}}

" Python - Pymode {{{
" syntax (colors for self keyword for example)
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1

" Disable all the rest, we only want syntax coloring
let g:pymode_indent = 1 " pep8 indent
let g:pymode_folding = 0 " disable folding to use SimpyFold
let g:pymode_motion = 1  " give jumps to functions / methods / classes
let g:pymode_doc = 0
let g:pymode_trim_whitespaces = 0 " do not trim unused white spaces on save
let g:pymode_rope = 0 " disable rope
let g:pymode_lint = 0  " disable lint
let g:pymode_breakpoint = 0  " disable it for custom

map <Leader>o o__import__("pdb").set_trace()  # BREAKPOINT<C-c>
map <Leader>O O__import__("pdb").set_trace()  # BREAKPOINT<C-c>
"import pdb; pdb.break_on_setattr('session_id')(container._sa_instance_state.__class__)
"map <Leader>i ofrom ptpython.repl import embed; embed()  # Enter ptpython<C-c>
map <Leader>i o__import__("IPython").embed()  # ipython embed<C-c>
" }}}

" Table Mode, Restructured text compatible {{{
au BufNewFile,BufRead *.rst let g:table_mode_header_fillchar='='
au BufNewFile,BufRead *.rst let g:table_mode_corner_corner='+'

au BufNewFile,BufRead *.py let g:table_mode_header_fillchar='='
au BufNewFile,BufRead *.py let g:table_mode_corner_corner='+'

au BufNewFile,BufRead *.md let g:table_mode_header_fillchar='-'
au BufNewFile,BufRead *.md let g:table_mode_corner_corner='|'
"}}}

" Terraform {{{
let g:terraform_fmt_on_save=1
let g:terraform_fold_sections=1
let g:terraform_align=1
" }}}

" Test and tmux {{{
nmap <silent> <leader>1 :Tmux <CR>:TestNearest<CR>
nmap <silent> <leader>2 :Tmux <CR>:TestLast<CR>
nmap <silent> <leader>3 :Tmux <CR>:TestFile<CR>
nmap <leader>v <Plug>SetTmuxVars
let test#strategy = 'tslime'
let g:test#preserve_screen = 1
let test#filename_modifier = ':~' " ~/Code/my_project/test/models/user_test.rb
"let test#python#pytest#options = '--log-level=DEBUG -x -s --pdb'
let test#python#pytest#options = '--log-level=WARNING -x -s'
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
"}}}

" TagBar & UndoTree & NERDTree
nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <F8> :UndotreeToggle<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>

" Loupe
let g:LoupeClearHighlightMap = 0
let g:LoupeVeryMagic = 0

" Git - gitgutter {{{
set signcolumn=yes
let g:conflict_marker_enable_mappings = 0
let g:gitgutter_max_signs = 200
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed = '•'
"}}}

" tmux, disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

"}}}

" User Interface {{{
filetype plugin indent on
syntax enable

set background=dark

let g:gruvbox_invert_selection=0
"let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
silent! colorscheme gruvbox " use of silence in case plugin are not yet installed

set mouse=a             " Automatically enable mouse usage
set mousehide           " Hide the mouse cursor while typing
set number              " display line number column
set relativenumber      " relative line number
set ruler               " Show the cursor position all the time
"set cursorline          " Highlight the line of the cursor
set guicursor=          " disable cursor-styling
set noshowmode          " do not put a message on the cmdline for the mode ('insert', 'normal', ...)

set scrolljump=5        " Lines to scroll when cursor leaves screen
set scrolloff=3         " Have some context around the current line always on screen
set virtualedit=onemore " Allow for cursor beyond last character
set hidden              " Allow backgrounding buffers without writin them, and remember marks/undo for backgrounded buffers
set foldenable          " Open all folds while not set.
set splitright          " split at the right of current buffer (left default behaviour)
set splitbelow          " split at the below of current buffer (top default behaviour)
set autochdir           " working directory is always the same as the file you are editing

set updatetime=300      " frequency to apply Autocmd events
set shortmess+=c        " don't pass messages to ins-completion-menu

set spelllang=en_us     " activate vim spell checking

set fillchars=vert:│    " box drawings heavy vertical (U+2503, UTF-8: E2 94 83)
highlight VertSplit ctermbg=none
highlight Normal guibg=none ctermbg=none

" Better diff views
hi DiffAdd cterm=none ctermfg=Green ctermbg=none
hi DiffChange cterm=none ctermfg=Yellow ctermbg=none
hi DiffDelete cterm=bold ctermfg=Red ctermbg=none
hi DiffText cterm=none ctermfg=Blue ctermbg=none

" Custom Fold Text {{{
function! CustomFoldText(delim)
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  " indent foldtext corresponding to foldlevel
  let indent = repeat(' ',shiftwidth())
  let foldLevelStr = repeat(indent, v:foldlevel-1)
  let foldLineHead = substitute(line, '^\s*', foldLevelStr, '')

  " size foldtext according to window width
  let w = winwidth(0) - &foldcolumn - (&number ? &numberwidth : 0)
  let foldSize = 1 + v:foldend - v:foldstart

  " estimate fold length
  let foldSizeStr = " " . foldSize . " lines "
  let lineCount = line("$")
  if has("float")
    try
      let foldPercentage = "[" . printf("%4s", printf("%.1f", (foldSize*1.0)/lineCount*100)) . "%] "
    catch /^Vim\%((\a\+)\)\=:E806/	" E806: Using Float as String
      let foldPercentage = printf("[of %d lines] ", lineCount)
    endtry
  endif

  " build up foldtext
  let foldLineTail = foldSizeStr . foldPercentage
  let lengthTail = strwidth(foldLineTail)
  let lengthHead = w - (lengthTail + indent)

  if strwidth(foldLineHead) > lengthHead
    let foldLineHead = strpart(foldLineHead, 0, lengthHead-2) . '..'
  endif

  let lengthMiddle = w - strwidth(foldLineHead.foldLineTail)

  " truncate foldtext according to window width
  let expansionString = repeat(a:delim, lengthMiddle)

  let foldLine = foldLineHead . expansionString . foldLineTail
  return foldLine
endfunction
autocmd FileType python set foldtext=CustomFoldText('\ ')
autocmd FileType python setlocal foldenable foldlevel=20
"}}}


if has('linebreak')
  let &showbreak='⤷ '   " arrow pointing downwards then curving rightwards (u+2937, utf-8: e2 a4 b7)
endif

" columns
set colorcolumn=100                    " Show vertical bar at column 100
au Filetype python set colorcolumn=100 " do it again for python overriden by some plugin

" cmdline
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" Whitespace
set nowrap                                     " don't wrap lines
set tabstop=2 expandtab                        " a tab is two spaces
set shiftwidth=2                               " an autoindent (with <<) is two spaces
set list                                       " show the following:
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set expandtab                                  " Spaces are used in indents"

" Backup, swap, undo & sessions {{{
for directory in ["backup", "swap", "undo", "view"]
  silent! call mkdir($HOME . "/.vim/" . directory, "p")
endfor

set backup                              " Backups are nice ...
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/

if has('persistent_undo')
  set undofile              " So is persistent undo ...
  set undolevels=1000       " Maximum number of changes that can be undone
  set undoreload=10000      " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.vim/undo/
endif

if has('mksession')
  set viewdir=~/.vim/view
  set viewoptions-=options  " needed by vim-stay
  "set viewoptions=folds,cursor,unix,slash " Better Unix / Windows compatibility
endif
" }}}

" Searching
set ignorecase " searches are case insensitive...
set smartcase  " ... unless they contain at least one capital letter

" edit file search path ignore
set wildignore+=**.egg-info/**
set wildignore+=**__pycache__/**

" Clipboard
if has('clipboard')
  if has('unnamedplus') " When possible use + register for copy-paste
    set clipboard+=unnamedplus
  endif
endif

"}}}

" Autocmd {{{

" Make sure all markdown files have the correct filetype set and setup
" wrapping and spell check
function! s:setupWrappingAndSpellcheck()
    set wrap
    set wrapmargin=2
    set textwidth=80
    set spell
endfunction
au BufRead,BufNewFile *.{md,md.erb,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrappingAndSpellcheck()

" Python
augroup python
  au FileType python set shiftwidth=4 tabstop=4 softtabstop=4
augroup end

" Other
au BufNewFile,BufRead *.snippets set filetype=snippets foldmethod=marker
au BufNewFile,BufRead *.sh set filetype=sh foldlevel=0 foldmethod=marker
au BufNewFile,BufRead *aliases set filetype=zsh foldlevel=0 foldmethod=marker
au BufNewFile,BufRead *.nix set filetype=nix
au BufNewFile,BufRead *.txt set filetype=sh
au BufNewFile,BufRead cronfile set filetype=sh
au BufNewFile,BufRead .gitconfig set filetype=conf
au BufNewFile,BufRead *.conf set filetype=config
au BufNewFile,BufRead *.kubeconfig set filetype=yaml
au BufNewFile,BufRead *.ya?ml set shiftwidth=2 tabstop=2 softtabstop=2

au BufNewFile,BufRead *.env set ft=sh
au BufNewFile,BufRead *.flaskenv set ft=sh

au Filetype vim set tabstop=2 foldmethod=marker

" frontend:
augroup frontend
  autocmd BufNewFile,BufRead *.html set shiftwidth=2 tabstop=2 softtabstop=2
  autocmd BufNewFile,BufRead *.html set foldmethod=syntax expandtab nowrap
  autocmd BufNewFile,BufRead *.html set foldlevelstart=20

  " avoid syntax highlighting stops working randomly in vue:
  autocmd FileType vue syntax sync fromstart
augroup end

" Git
augroup git
  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd FileType git setlocal foldlevelstart=20  " open all unfolded
augroup end

" Switch to the current file directory when a new buffer is opened
au BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
"}}}

" Mappings {{{

" Behaviour fixes {{{

" quick escape:
map <nowait> <Esc> <C-c>
cmap <nowait> <Esc> <C-c>

" Vim command line bindings to match zsh
" ALT + backspace in cmd to delete word, like in terminal
cmap <a-bs> <c-w>

" move beginning of line
cmap <c-a> <c-b>

" Move words
cmap <nowait> <M-b> <S-Left>
cmap <nowait> <M-f> <S-Right>

" Avoid vim history cmd to pop up with q:
nnoremap q: <Nop>

" Avoid entering some weird mode:
map <S-Q> <nop>

" Nvim Terminal
" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

" }}}

" activate spellcheck
map <leader>s :setlocal spell!<CR>

" select all of current paragraph with enter:
nnoremap <return> vip

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
nmap ZZ :wq<cr>

"{{{ Pane motions

" Are already mapped by vim-tmux-navigator
" easier navigation between split windows
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-h> <c-w>h
"nnoremap <c-l> <c-w>l

" Terminal mode:
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" Insert mode:
inoremap <c-h> <c-\><c-n><c-w>h
inoremap <c-j> <c-\><c-n><c-w>j
inoremap <c-k> <c-\><c-n><c-w>k
inoremap <c-l> <c-\><c-n><c-w>l

" Command mode:
cnoremap <c-h> <c-\><c-n><c-w>h
cnoremap <c-j> <c-\><c-n><c-w>j
cnoremap <c-k> <c-\><c-n><c-w>k
cnoremap <c-l> <c-\><c-n><c-w>l
"}}}

"{{{ Pane operations
" map open terminal
"map <nowait> <leader>n :vsplit \| terminal <CR>

" Buffers switch
map <nowait> œ :bp<cr>
map <nowait> ∑ :bn<cr>

" buffer delete without closing windows :
nmap <silent> ® :bp!\|bd! #<CR>

" Split windows
map <nowait> <leader>l :vs<cr>
map <nowait> ∂ :vs<cr>
map <nowait> <leader>' :sp<cr>
"}}}

"{{{ GoTo

"" Jedi for python
"augroup python
"  autocmd FileType python let g:jedi#goto_command = ""
"  autocmd FileType python let g:jedi#goto_assignments_command = "<leader>g"
"  autocmd FileType python let g:jedi#goto_definitions_command = "<leader>d"
"  autocmd FileType python let g:jedi#documentation_command = "<leader>k"
"  autocmd FileType python let g:jedi#usages_command = "<leader>n"
"  autocmd FileType python let g:jedi#rename_command = "<leader>r"
"augroup end

"" tern javascript
"augroup javascript
"  autocmd FileType javascript,vue nmap <leader>d :TernDef<cr>
"  autocmd FileType javascript,vue nmap <leader>k :TernDoc<cr>
"  autocmd FileType javascript,vue nmap <leader>n :TernRefs<cr>
"  autocmd FileType javascript,vue nmap <leader>r :TernRename<cr>
"  autocmd FileType javascript,vue nmap <leader>j :TernType<cr>
"augroup end

"}}}

"About folding open and close :
nnoremap <Space> za
vnoremap <Space> za

" Remap some motions:
noremap <nowait> w w
noremap <nowait> W b
noremap <nowait> e e
noremap <nowait> E ge

" copy to clipboard :
vnoremap <Leader>y "+y

" I never use the s in normal mode, so let substitue on pattern:
vnoremap s :s/

" easy save:
map <C-s> :w<CR>

" easy no hl
nmap <leader>; :nohl<cr>

" source config
map <F12> :source ${HOME}/.config/nvim/init.vim<cr>
"}}}


let g:python3_host_prog = $HOME . "/miniconda3/envs/neovim37/bin/python"
let g:python_host_prog = $HOME . "/miniconda3/envs/neovim27/bin/python"

" Specific config in ~/.config/nvim/nvimrc_local
if !empty(glob("~/config/nvim/nvimrc_local"))
    source ~/config/nvim/nvimrc_local
endif

" activate per project settings
set exrc  " allows loading local EXecuting local RC files
set secure  " disallows the use of :autocmd, shell and write commands in local


"" gitconfig:
""
"[core]
"  editor = nvim
"[merge]
"  tool = vimdiff
"[mergetool]
"  prompt = false
"[mergetool "vimdiff"]
"  cmd = nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'
"[difftool]
"  prompt=false
"[diff]
"  path = vimdiff
