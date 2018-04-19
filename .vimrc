scriptencoding utf-8

" This is mainly for non-neo vim and gvim, using Python 3, on
" OSX and Linux. fd and a NERD font are expected.

if filereadable(expand('$VIMRUNTIME/defaults.vim'))
	unlet! g:skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

packadd minpac
call minpac#init()
call minpac#add('Rip-Rip/clang_complete')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('airblade/vim-rooter')
call minpac#add('challenger-deep-theme/vim', {'name': 'challenger-deep-theme'})
call minpac#add('cespare/vim-toml')
call minpac#add('chrisbra/Colorizer')
call minpac#add('chriskempson/base16-vim')
call minpac#add('ctrlpvim/ctrlp.vim', {'type': 'opt'})
call minpac#add('dag/vim-fish')
call minpac#add('davidhalter/jedi-vim')
call minpac#add('jparise/vim-graphql')
call minpac#add('junegunn/fzf', {'type': 'opt'})
call minpac#add('junegunn/fzf.vim', {'type': 'opt'})
call minpac#add('junegunn/vim-slash')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('luochen1990/rainbow')
call minpac#add('machakann/vim-Verdin')
call minpac#add('mbbill/undotree')
call minpac#add('mhinz/vim-sayonara')
call minpac#add('mhinz/vim-startify')
call minpac#add('nixprime/cpsm', {'type': 'opt', 'do': {->system('env PY3=ON ./install.sh')}})
call minpac#add('roxma/nvim-completion-manager')
call minpac#add('roxma/vim-hug-neovim-rpc')
call minpac#add('racer-rust/vim-racer')
call minpac#add('rstacruz/vim-closer')
call minpac#add('ryanoasis/vim-devicons')
call minpac#add('ternjs/tern_for_vim', {'do': '!npm install'})
call minpac#add('thirtythreeforty/lessspace.vim')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rsi')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('w0rp/ale')
call minpac#add('xtal8/traces.vim')

if has('gui_running')
	packadd ctrlp.vim
	packadd cpsm
else
	packadd fzf
	packadd fzf.vim
endif

set autoindent
set autoread

" If you're having trouble on OS X, try building vim without --with-client-server.
" https://github.com/spf13/spf13-vim/issues/1018#issuecomment-287197190
set clipboard^=unnamedplus,unnamed

" Correct on Linux. Correct on OS X, AFAIK
if !has('nvim')
	set ttymouse=xterm2
endif

" Make sure this directory exists.
set backupdir=~/.cache/vim//
set directory=~/.cache/vim//
set undodir=~/.cache/vim//

" GitHub's desktop-browser web interface can display 137 characters per line without a horizontal scrollbar.
set colorcolumn=+1
set textwidth=137

set complete-=i
set display=lastline
set formatoptions+=j
set hidden
set infercase
set noshowmode
set number
set relativenumber
set sessionoptions-=options
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
set grepprg=rg\ --vimgrep
set shell=bash
set showmatch
set smartcase
set ttyfast
set undofile
set viminfo^=!
set visualbell
set wildignore+=*.pyc,*.o,*/.git/*,*/build/*,*.swp,*/.svn,*/.hg
set nowrap

" Ideas from here:
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
let &showbreak = '↪  '
set listchars=tab:\│\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲

set fillchars=vert:\│

let g:racer_cmd = expand('~/.cargo/bin/racer')

if has('mac')
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
	"let g:clang_library_path = '/Users/dugan/Qt//Qt Creator.app/Contents/Frameworks/libclang.dylib'
endif

let g:rainbow_active = 1

let g:ale_sign_column_always = 1
let g:ale_linters = {'javascript': ['jshint'], 'python': ['mypy']}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:startify_change_to_dir = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

if has('gui_running')
	let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
	nnoremap <leader>b :CtrlPBuffer<cr>
	let g:ctrlp_user_command = {
		\'types': {
			\1: ['.git', 'cd %s && git ls-files']
		\},
		\'fallback': 'fd --type f --color=never "" %s'
	\}
	let g:ctrlp_use_caching = 0
else
	" Mapping selecting mappings
	nmap <leader><tab> <plug>(fzf-maps-n)
	xmap <leader><tab> <plug>(fzf-maps-x)
	omap <leader><tab> <plug>(fzf-maps-o)

	" " Insert mode completion
	imap <c-x><c-k> <plug>(fzf-complete-word)
	imap <c-x><c-f> <plug>(fzf-complete-path)
	imap <c-x><c-j> <plug>(fzf-complete-file-ag)
	imap <c-x><c-l> <plug>(fzf-complete-line)

	" " Advanced customization using autoload functions
	inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

	nnoremap <c-p> :Files<cr>
	nnoremap <leader>t :GitFiles<cr>
	nnoremap <leader>b :Buffers<cr>
endif

augroup autocmds
	autocmd!
	autocmd FileType vifm setlocal filetype=vim
	autocmd FileType bash,sh set makeprg=shellcheck\ -f\ gcc\ %
	autocmd BufEnter,BufNew configure.ac set filetype=m4
	autocmd FileType qf setlocal nobuflisted
	autocmd BufEnter,BufNew .tern_project set ft=json
	autocmd FileType javascript.jsx setlocal expandtab tabstop=2 shiftwidth=2 equalprg=prettier
	autocmd FileType python setlocal foldmethod=indent equalprg=yapf
	autocmd FileType c,cpp setlocal equalprg=clang-format\ -style=file\ -assume-filename=%
	autocmd BufEnter,BufNew *.SlackBuild setlocal filetype=sh shiftwidth=2 expandtab tabstop=4
	autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ %
augroup END

:nmap <F4> :Gtags -f %<CR>
:nmap <C-\><C-]> :GtagsCursor<CR>
set cscopeprg=gtags-cscope

" TMux compatibility
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

if has('gui_running')
	colorscheme challenger_deep
	let g:airline_theme='challenger_deep'
else
	set termguicolors
	set background=dark
	colorscheme base16-tomorrow-night
	let g:airline_theme='base16_tomorrow'
endii
