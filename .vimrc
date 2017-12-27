set encoding=UTF-8
set title " タイトルにフォルダパスを追加
set termencoding=UTF-8
" set columns=200
" set lines=60 " 画面サイズ
scriptencoding utf-8
inoremap <silent> jj <ESC>
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
let twitvim_browser_cmd = 'open' " for Mac
let twitvim_force_ssl = 1
let twitvim_count = 40

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
