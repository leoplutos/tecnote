scriptencoding utf-8
"after/ftplugin/xml.vim

setlocal smartindent

"内容取自 https://github.com/chrisbra/vim-xml-runtime

setlocal commentstring=<!--%s-->
setlocal comments=s:<!--,e:-->

"格式化主函数
func! XmlFormat() abort
  if mode() != 'n'
    return 0
  endif
  let count_orig = v:count
  let sw  = shiftwidth()
  let prev = prevnonblank(v:lnum-1)
  let s:indent = indent(prev)/sw
  let result = []
  let lastitem = prev ? getline(prev) : ''
  let is_xml_decl = 0
  let list = getline(v:lnum, (v:lnum + count_orig - 1))
  let current = 0
  for line in list
    if empty(line)
      call add(result, '')
      continue
    elseif line !~# '<[/]\?[^>]*>'
      let nextmatch = match(list, '<[/]\?[^>]*>', current)
      if nextmatch > -1 
        let line .= ' '. join(list[(current + 1):(nextmatch-1)], " ")
        call remove(list, current+1, nextmatch-1)
      endif
    endif
    for item in split(line, '.\@<=[>]\zs')
      if s:EndTag(item)
        call s:DecreaseIndent()
        call add(result, s:Indent(item))
      elseif s:EmptyTag(lastitem)
        call add(result, s:Indent(item))
      elseif s:StartTag(lastitem) && s:IsTag(item)
        let s:indent += 1
        call add(result, s:Indent(item))
      else
        if !s:IsTag(item)
          let t=split(item, '.<\@=\zs')
          if s:TagContent(lastitem) is# s:TagContent(t[1]) && strlen(result[-1]) + strlen(item) <= s:Textwidth()
            let result[-1] .= item
            let lastitem = t[1]
            continue
          endif
          if s:IsTag(lastitem)
            let s:indent+=1
          endif
          let result+=s:FormatContent([t[0]])
          if s:EndTag(t[1])
            call s:DecreaseIndent()
          endif
          let result+=s:FormatContent(t[1:])
          if s:IsTag(t[1])
            let lastitem = t[1]
            continue
          endif
        elseif s:IsComment(item)
          let result+=s:FormatContent([item])
        else
          call add(result, s:Indent(item))
        endif
      endif
      let lastitem = item
    endfor
    let current += 1
  endfor

  if !empty(result)
    let lastprevline = getline(v:lnum + count_orig)
    let delete_lastline = v:lnum + count_orig - 1 == line('$')
    exe 'silent ' .. v:lnum. ",". (v:lnum + count_orig - 1). 'd'
    call append(v:lnum - 1, result)
    let last = v:lnum + len(result)
    if getline(last) is '' && lastprevline is '' && delete_lastline
      exe last. 'd'
    endif
  endif

  return 0
endfunc

func! s:IsXMLDecl(tag) abort
  return a:tag =~? '^\s*<?xml\s\?\%(version="[^"]*"\)\?\s\?\%(encoding="[^"]*"\)\? ?>\s*$'
endfunc

func! s:Indent(item) abort
  return repeat(' ', shiftwidth()*s:indent). s:Trim(a:item)
endfu

func! s:Trim(item) abort
  if exists('*trim')
    return trim(a:item)
  else
    return matchstr(a:item, '\S\+.*')
  endif
endfunc

func! s:StartTag(tag) abort
  let is_comment = s:IsComment(a:tag)
  return a:tag =~? '^\s*<[^/?]' && !is_comment
endfunc

func! s:IsComment(tag) abort
  return a:tag =~? '<!--'
endfunc

func! s:DecreaseIndent() abort
  let s:indent = (s:indent > 0 ? s:indent - 1 : 0)
endfunc

func! s:EndTag(tag) abort
  return a:tag =~? '^\s*</'
endfunc

func! s:IsTag(tag) abort
  return s:Trim(a:tag)[0] == '<'
endfunc

func! s:EmptyTag(tag) abort
  return a:tag =~ '/>\s*$'
endfunc

func! s:TagContent(tag) abort "{{{1
  return substitute(a:tag, '^\s*<[/]\?\([^>]*\)>\s*$', '\1', '')
endfunc

func! s:Textwidth() abort "{{{1
  return &textwidth == 0 ? 80 : &textwidth
endfunc

func! s:FormatContent(list) abort
  let result=[]
  let limit = s:Textwidth()
  let column=0
  let idx = -1
  let add_indent = 0
  let cnt = 0
  for item in a:list
    for word in split(item, '\s\+\S\+\zs') 
      if match(word, '^\s\+$') > -1
        continue
      endif
      let column += strdisplaywidth(word, column)
      if match(word, "^\\s*\n\\+\\s*$") > -1
        call add(result, '')
        let idx += 1
        let column = 0
        let add_indent = 1
      elseif column > limit || cnt == 0
        let add = s:Indent(s:Trim(word))
        call add(result, add)
        let column = strdisplaywidth(add)
        let idx += 1
      else
        if add_indent
          let result[idx] = s:Indent(s:Trim(word))
        else
          let result[idx] .= ' '. s:Trim(word)
        endif
        let add_indent = 0
      endif
      let cnt += 1
    endfor
  endfor
  return result
endfunc

setlocal formatoptions-=t
setlocal formatoptions+=croql
setlocal formatexpr=XmlFormat()
"nnoremap <buffer> <F10> :%!python -c "import xml.dom.minidom, sys, io; _stdin = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8'); reparsed = xml.dom.minidom.parse(_stdin); print('\n'.join([line for line in reparsed.toprettyxml().split('\n') if line.strip()]))"<CR>
