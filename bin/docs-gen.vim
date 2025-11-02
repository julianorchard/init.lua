#!/usr/bin/env sh
":"; exec nvim --headless -c "source ${0}" -c "qa"
" vi: ft=vim


let g:pluginFilePath = 'nvim-pack-lock.json'
let g:readmeFilePath = '.github/README.md'


function s:MarkdownLinkFormat(text, link) abort
  return '- [' . a:text . '](' . a:link . ') -test'
endfunction


function s:PluginMarkdownList() abort
  let l:pluginJson = readfile(g:pluginFilePath)
  let l:plugins = json_decode(l:pluginJson).plugins
  let l:outputList = []

  for [key, value] in items(l:plugins)
    let l:name = key
    let l:link = value.src

    call add(l:outputList, s:MarkdownLinkFormat(l:name, l:link))
  endfor

  return l:outputList
endfunction


function s:ReplaceReadmeContents(newMarkdown) abort
  let l:file = g:readmeFilePath
  let l:lines = readfile(l:file)
  let l:newLines = []

  let l:beginPattern = '<!--BEGIN_PLUGIN_LIST-->'
  let l:endPattern = '<!--END_PLUGIN_LIST-->'

  let l:foundBegin = v:false
  let l:foundEnd = v:false

  for l:line in l:lines
    if l:line =~ l:beginPattern
      let l:foundEnd = v:true
      let l:foundBegin = v:true
      call add(l:newLines, l:line)
      call extend(l:newLines, a:newMarkdown)
      continue
    endif

    if l:line =~ l:endPattern
      let l:foundBegin = v:false
      call add(l:newLines, l:line)
      continue
    endif

    " Only keep lines outside the block
    if !l:foundBegin
      call add(l:newLines, l:line)
    endif
  endfor

  if !l:foundEnd
    echom 'Plugin marker list markers not found in ' . g:readmeFilePath
  endif

  call writefile(l:newLines, l:file, 'S')
endfunction


let newMdList = s:PluginMarkdownList()
call s:ReplaceReadmeContents(newMdList)
