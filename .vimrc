set encoding=UTF-8
set title " タイトルにフォルダパスを追加
set termencoding=UTF-8
" set columns=200
" set lines=60 " 画面サイズ
scriptencoding utf-8
inoremap <silent> jj <ESC>
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>
nnoremap  <C-k> :Autoformat<CR>
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する
set nobackup " バックアップファイルを作らない
set noswapfile " Swapファイルを作らない
set number " 行番号を追加する
set cursorline "選択行にカーソルを追加
set tabstop=2
set shiftwidth=2
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数
set background=dark
set incsearch " 入力時点で検索を開始
set expandtab " タブを複数行括弧に変更
set autoindent " 改行時に前の行のインデントを利用する
set smartindent " 改行じに入力された行の直継に合わせて次の行のインデントを増減する
set hidden " 保存されて居ないファイルがあるときも別のファイルを開けるようにする
" Vimの補完設定を追加
set nocompatible
filetype plugin on
" vim-icon
set guifont=Nerd_Font:h11

" jvgrepが存在するときは置き換える
if executable('jvgrep')
  set grepprg=jvgrep
endif

" Dein.vim
" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

" {{{ dein
let s:dein_dir = expand('$DATA/dein')

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir
endif


" dein.vim settings

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir = expand('$CONFIG/dein')

    call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif
" }}}

au BufRead,BufNewFile *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1

colorscheme hybrid

" neocomplete
let g:deoplete#enable_at_startup = 1

" ターミナルモードの設定

" neovim terminal mapping
if has('nvim')
  " 新しいタブでターミナルを起動
  nnoremap @t :tabe<CR>:terminal<CR>
  " Ctrl + q でターミナルを終了
  tnoremap <C-q> <C-\><C-n>:q<CR>
  " ESCでターミナルモードからノーマルモードへ
  tnoremap <C-[> <C-\><C-n>
endif
" NERDTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 保存時の動作
autocmd BufWritePre * :%s/\s\+$//ge
autocmd BufWritePre * :%s/\t/  /ge

" NERDTree

let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks=1
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')


" Previm
 augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
hi link htmlItalic LineNr
hi link htmlBold WarningMsg
hi link htmlBoldItalic ErrorMsg

