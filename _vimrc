"シフト移動幅
set shiftwidth=4
"行頭の空白内でtabを打ち込むと，shiftindentの数だけインデント
set smarttab
"新しい行のインデントを現在行と同じにする
set autoindent
"新しい行を作ったときに高度な自動インデントを行う。
set smartindent
"変更中のファイルでも，保存しないでほかのファイルを表示
set hidden
"タブの代わりに空白文字を挿入する
set expandtab
"クリップボードをwindowsと連携
set clipboard=unnamed

"--------------------------------------------------------------------------
"pluginの設定
"タブエディタ風にバッファ管理ウインドを表示http://nanasi.jp/articles/vim/minibufexpl_vim.html
":let g:miniBufExplMapWindowNavVim=1
":let g:miniBufExplMapWindowNavArrows=1
":let g:miniBufExplMapTabSwitchBuffs=1
"タブを表示（0:非表示，1:複数のとき表示，2:常に表示）
set showtabline=2

"バックアップのファイルを格納するフォルダを指定
"set backupdir=$HOME/vimbackup
"バックアップなし
set nobackup
"行番号を表示する
set number
"ウィンドウサイズ縦横
"set lines=35
"set columns=100
"ファイルに応じて見やすく色付けをしてくれる
syntax on
set visualbell t_vb= " ビープ音なし
"VIM起動時に前回のセッションを復元する
"source <file>
"VIM終了時に現在のセッションを保存する
"au VimLeave * mks! <file>
"辞書ファイル読み込み
au FileType tex :set dict=~/vim/dict/tex.dict
au FileType verilog :set dict=~/vim/dict/verilog.dict
"バッファタブのパスを省略
let g:buftabs_only_basename=1
"背景を半透明に
gui
set transparency=200
"改行コードを自動認識
"set fileformat=unix,dos,mac
"バッファの一覧表示bufferlist
:map<silent><F3> :call BufferList()<CR>
"自動改行しない
set tw=0

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/ 

"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
"trailは行末スペース。
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:< 

"括弧の中に戻る
    imap {} {}<Left>
    imap [] []<Left>
    imap () ()<Left>
    imap "" ""<Left>
    imap '' ''<Left>
    imap <> <><Left>

"IMEでのon/off色設定
hi CursorIM  guifg=black  guibg=orange  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse

"unite設定
""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" 初期設定関数を起動する
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
endfunction
" 様々なショートカット
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
if has('win32') || has('win64')
  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/')
  call unite#set_substitute_pattern('file', '^;v', '~/vimfiles/')
else
  call unite#set_substitute_pattern('file', '^;v', '~/.vim/')
endif

"カレントディレクトリを自動的に移動
augroup BufferAu
    autocmd!
    " カレントディレクトリを自動的に移動
    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
augroup END
