"�V�t�g�ړ���
set shiftwidth=4
"�s���̋󔒓���tab��ł����ނƁCshiftindent�̐������C���f���g
set smarttab
"�V�����s�̃C���f���g�����ݍs�Ɠ����ɂ���
set autoindent
"�V�����s��������Ƃ��ɍ��x�Ȏ����C���f���g���s���B
set smartindent
"�ύX���̃t�@�C���ł��C�ۑ����Ȃ��łق��̃t�@�C����\��
set hidden
"�^�u�̑���ɋ󔒕�����}������
set expandtab
"�N���b�v�{�[�h��windows�ƘA�g
set clipboard=unnamed

"--------------------------------------------------------------------------
"plugin�̐ݒ�
"�^�u�G�f�B�^���Ƀo�b�t�@�Ǘ��E�C���h��\��http://nanasi.jp/articles/vim/minibufexpl_vim.html
":let g:miniBufExplMapWindowNavVim=1
":let g:miniBufExplMapWindowNavArrows=1
":let g:miniBufExplMapTabSwitchBuffs=1
"�^�u��\���i0:��\���C1:�����̂Ƃ��\���C2:��ɕ\���j
set showtabline=2

"�o�b�N�A�b�v�̃t�@�C�����i�[����t�H���_���w��
"set backupdir=$HOME/vimbackup
"�o�b�N�A�b�v�Ȃ�
set nobackup
"�s�ԍ���\������
set number
"�E�B���h�E�T�C�Y�c��
"set lines=35
"set columns=100
"�t�@�C���ɉ����Č��₷���F�t�������Ă����
syntax on
set visualbell t_vb= " �r�[�v���Ȃ�
"VIM�N�����ɑO��̃Z�b�V�����𕜌�����
"source <file>
"VIM�I�����Ɍ��݂̃Z�b�V������ۑ�����
"au VimLeave * mks! <file>
"�����t�@�C���ǂݍ���
au FileType tex :set dict=~/vim/dict/tex.dict
au FileType verilog :set dict=~/vim/dict/verilog.dict
"�o�b�t�@�^�u�̃p�X���ȗ�
let g:buftabs_only_basename=1
"�w�i�𔼓�����
gui
set transparency=200
"���s�R�[�h�������F��
"set fileformat=unix,dos,mac
"�o�b�t�@�̈ꗗ�\��bufferlist
:map<silent><F3> :call BufferList()<CR>
"�������s���Ȃ�
set tw=0

"�S�p�X�y�[�X�����o��
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /�@/ 

"���ꕶ��(SpecialKey)�̌����鉻�Blistchars��lcs�ł��ݒ�\�B
"trail�͍s���X�y�[�X�B
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:< 

"���ʂ̒��ɖ߂�
    imap {} {}<Left>
    imap [] []<Left>
    imap () ()<Left>
    imap "" ""<Left>
    imap '' ''<Left>
    imap <> <><Left>

"IME�ł�on/off�F�ݒ�
hi CursorIM  guifg=black  guibg=orange  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse

"unite�ݒ�
""" unite.vim
" ���̓��[�h�ŊJ�n����
let g:unite_enable_start_insert=1
" �o�b�t�@�ꗗ
noremap <C-P> :Unite buffer<CR>
" �t�@�C���ꗗ
noremap <C-N> :Unite -buffer-name=file file<CR>
" �ŋߎg�����t�@�C���̈ꗗ
noremap <C-Z> :Unite file_mru<CR>
" �E�B���h�E�𕪊����ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" �E�B���h�E���c�ɕ������ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESC�L�[��2�񉟂��ƏI������
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" �����ݒ�֐����N������
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
endfunction
" �l�X�ȃV���[�g�J�b�g
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

"�J�����g�f�B���N�g���������I�Ɉړ�
augroup BufferAu
    autocmd!
    " �J�����g�f�B���N�g���������I�Ɉړ�
    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
augroup END
