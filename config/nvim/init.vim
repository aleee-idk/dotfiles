" vim:fileencoding=utf-8:foldmethod=marker

" Plugins:{{{
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'

"" Core: {{{
Plug 'antoinemadec/FixCursorHold.nvim' " Fix some performance bugs
"Plug 'valloric/youcompleteme'      " Code completion
Plug 'bkad/camelcasemotion'         " Move with camel case or snake case instead of words
Plug 'tpope/vim-surround'           " Change or add text surrounding an element
Plug 'simeji/winresizer'            " Resize and Rearrange windows more easily
Plug 'simnalamburt/vim-mundo'       " Undo tree viewer
Plug 'liuchengxu/vim-which-key'     " Keybindings popup
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'         " General-purpose command-line fuzzy finder.
Plug 'voldikss/vim-floaterm'        " Neovim floating terminalPlug 'antoinemadec/FixCursorHold.nvim'
Plug 'ActivityWatch/aw-watcher-vim' " Time tracker
Plug 'mhinz/vim-startify'           " Start Page
"" }}}

"" Code Utilities: {{{
Plug 'neoclide/coc.nvim',
            \ {'branch': 'release'} " Code completion and stuff
Plug 'cdelledonne/vim-cmake'        " Cmake generation and build
Plug 'vim-test/vim-test'            " Run test inside Vim
Plug 'tpope/vim-commentary'         " Add commentary support to Vim
Plug 'iamcco/markdown-preview.nvim', " Markdown live preview in web browser
            \{ 'do': 'cd app && yarn install'  }
Plug 'mzlogin/vim-markdown-toc'     " Markdown table of contents
Plug 'mattn/webapi-vim'             " An Interface to WEB APIs.
Plug 'habamax/vim-godot'        " Godot support for Vim
Plug 'tmhedberg/simpylfold'   " Fold support for Python
Plug 'SirVer/ultisnips'         " Snippets
Plug 'honza/vim-snippets'

"" }}}

"" File Management: {{{
" Plug 'vifm/vifm.vim'                " File Explorer
" Plug 'francoiscabrol/ranger.vim'    " Ranger file explorer in Vim
" Plug 'scrooloose/nerdtree'          " File tree explorer
Plug 'lambdalisue/fern.vim'         " File tree explorer
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-hijack.vim'    " Fern as default file explorer
Plug 'lambdalisue/fern-git-status.vim'

""}}}

"" Git: {{{
Plug 'tpope/vim-fugitive'           " Git commands
Plug 'airblade/vim-gitgutter'       " Git information
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git status for NERDTree
""}}}

"" Better Looking: {{{
Plug 'chiel92/vim-autoformat'       " Format with one button press (or automatically on save)
Plug 'itchyny/lightline.vim'        " Status Line
Plug 'ap/vim-css-color'             " Display Hex colors
Plug 'luochen1990/rainbow'          " Parentheses (and other surrounding elements) colors
Plug 'ryanoasis/vim-devicons'       " Icons for some other plugins
Plug 'lambdalisue/nerdfont.vim'     " Nerdfonts in vim
"" }}}

"" Color Scheme {{{
" Plug 'dylanaraps/wal.vim'           " Current wallpaper colorscheme
" Plug 'arcticicestudio/nord-vim'     " Nord color scheme
Plug 'ghifarit53/tokyonight-vim'    " Tokyonight color scheme
" Plug 'marko-cerovac/material.nvim'
Plug 'shaunsingh/moonlight.nvim'      " Fork of material
"" }}}

"" Misc: {{{
" Plug 'vimwiki/vimwiki'              " Personal Wiki for Vim
Plug 'mattn/calendar-vim'           " Calendar utilities
"" }}}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"""}}}

" General customization: {{{

"" Basic Settings

" Use system clipboard
set clipboard+=unnamedplus

" enable mouse
set mouse=a

" Number settings
set number relativenumber

" True colors support
" set termguicolors

" Color Scheme (moved to moonlight)
" colorscheme material

" Line highlight (color theme have preference over this)
" set cursorline
" highlight CursorLine cterm=bold ctermbg=13
" highlight CursorLineNr ctermbg=red
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Column highlight (color theme have preference over this)
" set cursorcolumn
" highlight CursorColumn ctermbg=Cyan cterm=bold guibg=#2b2b2b

" Syntax highlight
syntax on

" Tabs and identation
set tabstop=4 shiftwidth=4 expandtab

" Keep cursor centered
set scrolloff=15

" Autocompletion
set wildmode=longest,list,full

" disable Case sensitive
set ignorecase

set smartcase

" Fix splitting
set splitbelow splitright

"" Custom Maping

" Custom leader key
let mapleader = "\<Space>"

" Toggle auto comment
map <Leader>c :setlocal formatoptions-=cro<CR>
map <Leader>C :setlocal formatoptions=cro<CR>

" Toggle auto indent
map <Leader>i :setlocal autoindent<CR>
map <Leader>I :setlocal noautoindent<CR>

" Enable spell checking
map <Leader>s :setlocal spell! spelllang=en:us<CR>

" Split navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Split move
nmap <M-h> -1<C-w>x
nmap <M-j> <C-w>x
nmap <M-k> <C-w>x
nmap <M-l> 1<C-w>x

" Insert Current date
nnoremap <F5> "=strftime("%B %d of %Y, %A")<CR>P
inoremap <F5> <C-R>=strftime("%B %d of %Y, %A")<CR>

"" Files Handling
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *vimwiki* set filetype=markdown

"" AutoComands

" Auto vertically center line on enter insert mode
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Persistent undo
" save undo trees in files

set undofile
set undodir=~/.vim/undo

" number of undo saved
set undolevels=10000

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


" This enable folding for markdown
let g:markdown_folding = 2

"" GUI Config {{{

set guifont=CaskaydiaCove\ Nerd\ Font:15

""" neovide {{{

" let g:neovide_transparency=0.8

let g:neovide_cursor_vfx_mode = "pixiedust"

"
""" neovide }}}

"" GUI Config }}}

" }}}

" Plugin Configuration: {{{

"" Floaterm {{{

let g:floaterm_keymap_new    = '<C-t><C-n>'
let g:floaterm_keymap_prev   = '<C-t><C-p>'
let g:floaterm_keymap_next   = '<C-t><C-n>'
let g:floaterm_keymap_toggle = '<C-t><C-t>'

"" }}}

"" Winresizer {{{
let g:winresizer_start_key = "<Leader>r"

let g:winresizer_gui_enable = 1

let g:winresizer_finish_with_escape = 1

"" }}}

"" Which-Key {{{

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" set timeoutlen=100

"" }}}

"" FZF {{{

nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>fb :Buffers<CR>

" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)
" command! -bang -nargs=? -complete=dir GFiles
"   \ call fzf#vim#gitfiles(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)

"" }}}

"" Lightline: {{{
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'Branch',
            \   'filename': 'LightlineFilename',
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat',
            \ },
            \ }

function! Branch()
    return ' ' . FugitiveHead()
endfunction

function! LightlineFilename()
    return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
                \ &filetype ==# 'unite' ? unite#get_status_string() :
                \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
                \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
"" }}}

"" Rainbow: {{{
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
            \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \    'ctermfgs': ['cyan', 'darkgreen', 'red', 'magenta'],
            \}
nnoremap <f1> :echo synIDattr(synID(line('.'), col('.'), 0), 'name')<cr>
nnoremap <f2> :echo ("hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">")<cr>
nnoremap <f3> :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>
nnoremap <f4> :exec 'syn list '.synIDattr(synID(line('.'), col('.'), 0), 'name')<cr>
"" }}}

"" COC: {{{
" " TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g{ <Plug>(coc-diagnostic-prev)
nmap <silent> g} <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>cr <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>cac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cqf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"     nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"     nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"     inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"     inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"     vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"     vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"" }}}

"" Autoformat {{{

" Format on save
au BufWrite * :Autoformat
autocmd FileType txt,tex,text,yaml,yml,md let b:autoformat_autoindent=0

"" }}}

"" Ultisnips {{{

" Default config
" let g:UltiSnipsExpandTrigger="<c-tab>"

" let g:UltiSnipsJumpForwardTrigger="<leader>n"
" let g:UltiSnipsJumpBackwardTrigger="<leader>b"


" This works for me with COC
let g:UltiSnipsExpandTrigger = '<Nop>'

imap <C-Tab> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev = '<C-b>'


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"" }}}

"" CMake {{{

let g:cmake_link_compile_commands = 1

nmap <Leader>cg :CMakeGenerate<cr>
nmap <Leader>cb :CMakeBuild<cr>

"" }}}

"" VimWiki: {{{
" set nocompatible
" filetype plugin on
" let g:vimwiki_folding='expr'

" let g:vimwiki_list = [{'path': '~/Documents/Notes',
" \ 'syntax': 'markdown', 'ext':'.md',}]
"" }}}

"" Markdown Preview: {{{

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
" let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'qutebrowser'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'relative',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {},
            \ 'flowchart_diagrams': {},
            \ 'content_editable': v:false,
            \ 'disable_filename': 0
            \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown', 'md', 'vimwiki']

"" }}}

"" NERDTree: {{{

" " Open NERDTree
" nmap <C-f> :NERDTreeToggle<CR>
"
" " Auto open NERDTree
" " if !exists('g:started_by_firenvim')
" "     autocmd VimEnter * NERDTree | wincmd p
" " endif
"
" " Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
"
" " Auto leave if NERDTree is the only buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" " Mirror the NERDTree before showing it. This makes it the same on all tabs.
" nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

""}}}

"" Fern {{{

let g:fern#drawer_width = 30
" Show hidden files by default
" let g:fern#default_hidden = 1
" Don't close vim if fern is open
" let g:fern#disable_drawer_smart_quit = 1

noremap <silent><C-f> :Fern . -drawer <CR>
noremap <silent><M-f> :FernDo close -drawer <CR>

function! s:init_fern() abort

    nmap <buffer> v <Plug>(fern-action-open:split)
    nmap <buffer> s <Plug>(fern-action-open:vsplit)
    nmap <buffer> o <Plug>(fern-action-open:select)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> C <Plug>(fern-action-copy)
    nmap <buffer> N <Plug>(fern-action-new-path)
    nmap <buffer> H <Plug>(fern-action-hidden:toggle)
    nmap <silent><buffer> O <Plug>(fern-action-cd)
                \ :Fern . -drawer <CR>
    nmap <buffer> <leader> <Plug>(fern-action-mark)
endfunction

" Custom open
augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

" You need this otherwise you cannot switch modified buffer
set hidden


let g:fern#renderer = "nerdfont"

"" }}}

"" Tokyonight {{{

let g:tokyonight_style = 'storm'
let g:tokyonight_transparent_background = 1
let g:tokyonight_menu_selection_background = 'blue'
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

"" }}}

"" Material {{{

let g:material_style = "moonlight"
let g:material_italic_comments = 1
let g:material_italic_keywords = 1
let g:material_italic_functions = 1
let g:material_italic_variables = 1
let g:material_contrast = 0
let g:material_borders = 0
let g:material_disable_background = "true"

"" Load the colorsheme
" colorscheme material

""}}}

" }}}

