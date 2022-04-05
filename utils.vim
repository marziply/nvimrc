com! -nargs=0 -range Vcp norm! gv"ay
com! -nargs=1 -complete=buffer Vsb vert sb <args>
com! -nargs=1 Cman vert Man 3 <args>

fun! VisualSearch (num, chars = '')
  exec 'VisualCopy'
  call feedkeys(':%s/' . @a . '//g' . a:chars)

  for i in range(0, a:num)
    call feedkeys("\<left>")
  endfor
endfun

fun! ExecSilently (cmd)
  let cmd = substitute(a:cmd, "^!", "", "")
  let cmd = substitute(cmd, "%", shellescape(expand("%")), "")

  call system(cmd)
endfun

fun! FoldApiBlocks (global)
  let g_str = a:global == 1 ? 'g' : ''
  let top_str = a:global == 1 ? 'gg' : ''

  exec 'silent!' . g_str . ' /@openapi/,/\n[ ]\+\*\//fo | norm ' . top_str . 'zM'
endfun

fun! GetNextSippet ()
  call feedkeys("\<c-r>=coc#rpc#request('snippetNext', [])\<cr>")
endfun

fun! CheckJumpable (callback)
  if coc#jumpable()
    call GetNextSippet()
  elseif a:callback
    if has('*' . a:callback)
      exec 'call ' . a:callback . '()'
    else
      call feedkeys(a:callback)
    endif
  endif
endfun

" CoC method for checking if previous character is a space
fun! CheckDel () abort
  let col = col('.') - 1

  if !col || getline('.')[col - 1] =~# '\s'
    call feedkeys("\<tab>")
  else
    call coc#refresh()
  endif
endfun

" Set custom 'one' colourscheme colours
fun! SetColours ()
  if exists("*one#highlight")
    call one#highlight("Normal", "bbbbbb", "202020", "")
    call one#highlight("Include", "c678dd", "", "none")
    call one#highlight("StorageClass", "c678dd", "", "none")
    call one#highlight("LineNr", "a8a171", "", "none")
    call one#highlight("CursorLineNr", "ffffff", "", "none")
    call one#highlight("Constant", "e06c75", "", "none")
    call one#highlight("ColorColumn", "", "292929", "")
    call one#highlight("CursorColumn", "", "424752", "none")
    call one#highlight("CursorLine", "", "32353c", "none")
    call one#highlight("NonText", "8d93a1", "", "none")
  endif
endfun

" Get character at given pos distance away from the cursor
fun! GetChar (pos)
  let this_char = getline(".")[col(".") - a:pos:]

  return strcharpart(this_char, 0, 1)
endfun

fun! EditVimConf (split)
  let options = [
    \ 'Vars',
    \ 'Utils',
    \ 'Mappings',
    \ 'Settings',
    \ 'Init'
  \]
  let choices = join(map(options, '"&" . v:val'), "\n")
  let sel = confirm("Choose Vim config", choices)

  if sel > 0
    let file = sel == 5 ? 'init.vim' : g:imports[sel - 1]
    let edit = a:split == 1 ? 'vs' : 'e'

    exec edit . " $NVIM_DIR/" . file
  endif
endfun

fun! CommitChanges ()
  call inputsave()

  let msg = input('commit message: ')

  call inputrestore()

  let cmd = [
    \ "!cd $NVIM_DIR",
    \ 'git add .',
    \ 'git commit -am "' . msg . '"',
    \ 'git push'
  \]

  silent exec join(cmd, ' && ')

  redraw!

  echo 'committed and pushed'
endfun

fun! FoldAllBlocks ()
  let this_line = line(".")
  let matched = 1

  norm! gg

  while matched > 0
    let matched = search(g:block_reg, "eW")

    norm! V%zfj
    execute "norm! \<esc>"
  endwhile

  execute this_line

  norm! zz
endfun

fun! ShellOutput (cmd)
  let s = @s

  norm! gv"sy

  call setreg('h', system("echo '" . getreg('s') . "' | " . a:cmd))

  norm! gv
  norm! "hp
endfun

fun! EasyMotionCoc() abort
  if EasyMotion#is_active()
    let g:easymotion#is_active = 1

    silent! CocDisable
  else
    if g:easymotion#is_active == 1
      let g:easymotion#is_active = 0

      silent! CocEnable
    endif
  endif
endfun

fun! ToggleRelative()
  let rn = &relativenumber

  set rnu!

  aug rnu
    au!

    if rn == 0
      au CursorMoved * ++once call ToggleRelative()
    else
      au!
    endif
  aug end
endfun
