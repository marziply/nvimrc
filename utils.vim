com! -nargs=0 -range YankVisual norm! gv"ay
com! -nargs=1 -complete=buffer Vsb vert sb <args>
com! -nargs=1 Cman vert Man 3 <args>
com! -nargs=1 Silent call SilentExec(<q-args>)

fun! FoldApiBlocks (global)
  let g_str = a:global == 1 ? 'g' : ''
  let top_str = a:global == 1 ? 'gg' : ''

  exec 'silent!' . g_str . ' /@openapi/,/\n[ ]\+\*\//fo | norm ' . top_str . 'zM'
endfun

fun! FindComponent (name, split)
  let l:result = system('fd -e vue -t f "' . a:name . '"' . ' .')
  let l:list = split(l:result, '\n')
  let l:num = len(l:list)

  if l:num == 0
    echo "'" . a:name . "' not found"

    return
  endif

  if l:num > 1
    let tmpfile = tempname()

    exe 'redir! > ' . tmpfile

    silent echon l:result

    redir END

    let old_efm = &efm

    setl efm=%f

    let cmd = exists(':cgetfile') ? 'cgetfile' : 'cfile'

    exec 'silent! ' . cmd . ' ' . tmpfile

    botright copen

    let &efm = old_efm

    call delete(tmpfile)

    return
  endif

  let edit = a:split == 1 ? 'vs' : 'e'

  exec edit . ' ' . l:list[0]
endfun

" COC method for checking if previous character is a space
fun! CheckBackSpace () abort
  let col = col('.') - 1

  return !col || getline('.')[col - 1] =~# '\s'
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

" Format single line HTML tags to multi line tags
fun! MultilineTag ()
  norm ^

  SplitjoinSplit

  norm ^%

  if GetChar(2) == "/" | call feedkeys("hhx") | endif

  call feedkeys("Y\<cr>$%")
endfun

fun! MatchTag ()
  let this_line = getline('.')
  let matched_tag = matchstr(this_line, '<[A-Za-z-]\+')

  if empty(matched_tag)
    throw "No matches"
  else
    return matched_tag
  endif
endfun

" Search globally for either tag on given line or from the filename
fun! SearchTag (search_dir)
  let ctrlsf_com = 'CtrlSF -R -W -S "'

  if a:search_dir
    let this_file = expand("%:t:r")
    let search_string = "<" . this_file

    execute ctrlsf_com . search_string . '"'
  else
    try
      let matched_tag = MatchTag()
      execute ctrlsf_com . matched_tag . '"'
    catch
      echo v:exception
    endtry
  endif
endfun

fun! GoToTag (split)
  try
    let matched_tag = MatchTag()

    call FindComponent(matched_tag[1:], a:split)
  catch
    echo v:exception
  endtry
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

  let msg = input('Commit message: ')

  call inputrestore()

  let cmd = [
    \ "!cd $NVIM_DIR",
    \ 'git add .',
    \ 'git commit -am "' . msg . '"',
    \ 'git push'
  \]

  silent exec join(cmd, ' && ')

  redraw!

  echo 'Committed and pushed'
endfun

fun! SilentExec (cmd)
  let cmd = substitute(a:cmd, "^!", "", "")
  let cmd = substitute(cmd, "%", shellescape(expand("%")), "")

  call system(cmd)
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
