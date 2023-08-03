scriptencoding utf-8
"terminal.vim

if has('terminal')
  "设定快捷键
  let g:terminal_key = '<Leader>a'
  "终端窗口高度
  let g:terminal_height=30
  "设置为 1 以在进程完成时关闭窗口
  let g:terminal_close=1
  " 0: vim's current working directory (which :pwd returns)
  " 1: file path of current file.
  " 2: project root of current file.
  let g:terminal_cwd = 1
  "----------------------------------------------------------------------
  " open a new/previous terminal
  "----------------------------------------------------------------------
  function! TerminalOpen(...)
    let bid = get(t:, '__terminal_bid__', -1)
    let pos = get(g:, 'terminal_pos', 'rightbelow')
    let height = get(g:, 'terminal_height', 10)
    let succeed = 0
    function! s:terminal_view(mode)
      if a:mode == 0
        let w:__terminal_view__ = winsaveview()
      elseif exists('w:__terminal_view__')
        call winrestview(w:__terminal_view__)
        unlet w:__terminal_view__
      endif
    endfunc
    let uid = win_getid()
    keepalt noautocmd windo call s:terminal_view(0)
    keepalt noautocmd call win_gotoid(uid)
    if bid > 0
      let name = bufname(bid)
      if name != ''
        let wid = bufwinnr(bid)
        if wid < 0
          exec pos . ' ' . height . 'split'
          exec 'b '. bid
          if mode() != 't'
            if has('nvim')
              startinsert
            else
              exec "normal! i"
            endif
          endif
        else
          exec "normal! ". wid . "\<c-w>w"
        endif
        let succeed = 1
      endif
    endif
    if has('nvim')
      let cd = haslocaldir()? 'lcd' : (haslocaldir(-1, 0)? 'tcd' : 'cd')
    else
      let cd = haslocaldir()? ((haslocaldir() == 1)? 'lcd' : 'tcd') : 'cd'
    endif
    if succeed == 0
      let shell = get(g:, 'terminal_shell', '')
      let command = (shell != '')? shell : &shell
      let close = get(g:, 'terminal_close', 0)
      if has('nvim') && 0
        for ii in range(winnr('$') + 8)
          let info = nvim_win_get_config(0)
          if has_key(info, 'anchor') == 0
            break
          endif
          keepalt noautocmd exec "normal! \<c-w>w"
        endfor
        let uid = win_getid()
      endif
      let savedir = getcwd()
      if &bt == ''
        if g:terminal_cwd == 1
          let workdir = (expand('%') == '')? getcwd() : expand('%:p:h')
          silent noautocmd execute cd . ' '. fnameescape(workdir)
        elseif g:terminal_cwd == 2
          silent noautocmd execute cd . ' '. fnameescape(s:project_root())
        endif
      endif
      if has('nvim') == 0
        exec pos . ' ' . height . 'split'
        let opts = {'curwin':1, 'norestore':1, 'term_finish':'open'}
        let opts.term_kill = get(g:, 'terminal_kill', 'term')
        let opts.exit_cb = function('s:terminal_exit')
        let bid = term_start(command, opts)
        setlocal nonumber norelativenumber signcolumn=no
        let jid = term_getjob(bid)
        let b:__terminal_jid__ = jid
      else
        exec pos . ' ' . height . 'split'
        exec 'enew'
        let opts = {}
        let opts.on_exit = function('s:terminal_exit')
        let jid = termopen(command, opts)
        setlocal nonumber norelativenumber signcolumn=no
        let b:__terminal_jid__ = jid
        startinsert
      endif
      silent noautocmd execute cd . ' '. fnameescape(savedir)
      let t:__terminal_bid__ = bufnr('')
      setlocal bufhidden=hide
      if get(g:, 'terminal_list', 1) == 0
        setlocal nobuflisted
      endif
      if get(g:, 'terminal_auto_insert', 0) != 0
        if has('nvim') == 0
          autocmd WinEnter <buffer> exec "normal! i"
        else
          autocmd WinEnter <buffer> startinsert
        endif
      endif
    endif
    let x = win_getid()
    noautocmd windo call s:terminal_view(1)
    noautocmd call win_gotoid(uid)    " take care of previous window
    noautocmd call win_gotoid(x)
    if get(g:, 'terminal_fixheight', 0)
      setlocal winfixheight
    endif
  endfunc
  "----------------------------------------------------------------------
  " hide terminal
  "----------------------------------------------------------------------
  function! TerminalClose()
    let bid = get(t:, '__terminal_bid__', -1)
    if bid < 0
      return
    endif
    let name = bufname(bid)
    if name == ''
      return
    endif
    let wid = bufwinnr(bid)
    if wid < 0
      return
    endif
    let sid = win_getid()
    noautocmd windo call s:terminal_view(0)
    call win_gotoid(sid)
    if wid != winnr()
      let uid = win_getid()
      exec "normal! ". wid . "\<c-w>w"
      close
      call win_gotoid(uid)
    else
      close
    endif
    let sid = win_getid()
    noautocmd windo call s:terminal_view(1)
    call win_gotoid(sid)
    let jid = getbufvar(bid, '__terminal_jid__', -1)
    let dead = 0
    if has('nvim') == 0
      if type(jid) == v:t_job
        let dead = (job_status(jid) == 'dead')? 1 : 0
      endif
    else
      if jid >= 0
        try
          let pid = jobpid(jid)
        catch /^Vim\%((\a\+)\)\=:E900:/
          let dead = 1
        endtry
      endif
    endif
    if dead
      exec 'bdelete! '. bid
    endif
  endfunc
  "----------------------------------------------------------------------
  " process exit callback
  "----------------------------------------------------------------------
  function! s:terminal_exit(...)
    let close = get(g:, 'terminal_close', 0)
    if close != 0
      let bid = get(t:, '__terminal_bid__', -1)
      let alive = 0
      if bid > 0 && bufname(bid) != ''
        let alive = (bufwinnr(bid) > 0)? 1 : 0
      endif
      if alive
        call TerminalClose()
      elseif bid > 0
        exec 'bdelete! '.bid
      endif
    endif
  endfunc
  "----------------------------------------------------------------------
  " toggle open/close
  "----------------------------------------------------------------------
  function! TerminalToggle()
    let bid = get(t:, '__terminal_bid__', -1)
    let alive = 0
    if bid > 0 && bufname(bid) != ''
      let alive = (bufwinnr(bid) > 0)? 1 : 0
    endif
    if alive == 0
      call TerminalOpen()
    else
      call TerminalClose()
    endif
  endfunc
  "----------------------------------------------------------------------
  " 绑定快捷键
  "----------------------------------------------------------------------
  let s:cmd = 'nnoremap <silent>'.(g:terminal_key). ' '
  exec s:cmd . ':call TerminalToggle()<cr>'
  "if has('nvim') == 0
    "let s:cmd = 'tnoremap <silent>'.(g:terminal_key). ' '
    "exec s:cmd . '<c-_>:call TerminalToggle()<cr>'
  "else
    let s:cmd = 'tnoremap <silent>'.(g:terminal_key). ' '
    exec s:cmd . '<c-\><c-n>:call TerminalToggle()<cr>'
  "endif
endif
