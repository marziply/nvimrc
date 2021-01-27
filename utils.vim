com! -nargs=1 -complete=buffer Vsb :vert sb <args>
com! -nargs=1 Cman :vert Man 3 <args>
com! -nargs=1 Silent call SilentExec(<q-args>)

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
fun! EscapeString (string)
  let string = a:string
  let string = escape(string, '^$.*\/~[]')
  let string = substitute(string, '\n', '\\n', "g")

  return string
endfun

" Get the current visual block for search and replaces
" This fun passed the visual block through a string escape fun
" https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
fun! GetVisual () range
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard

  set clipboard&
  norm! ""gvy

  let selection = getreg('"')

  call setreg('"', reg_save, regtype_save)

  let &clipboard = cb_save
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfun

fun! Find (name, split)
  let l:result = system("fd -e vue -t f \"" . a:name . "\"" . " .")
  let l:list = split(l:result, '\n')
  let l:num = len(l:list)

  if l:num == 0
    echo "'" . a:name . "' not found"

    return
  endif

  if l:num > 1
    let tmpfile = tempname()

    exe "redir! > " . tmpfile

    silent echon l:result

    redir END

    let old_efm = &efm

    setl efm=%f

    if exists(":cgetfile")
        exec "silent! cgetfile " . tmpfile
    else
        exec "silent! cfile " . tmpfile
    endif

    botright copen

    let &efm = old_efm

    call delete(tmpfile)

    return
  endif

  if a:split == 1
    execute ":vs " . l:list[0]
  else
    execute ":e " . l:list[0]
  endif
endfun

fun! FindNew (name)
  let list = system("find . -name '" . a:name)
endfun

" COC method for checking if previous character is a space
fun! CheckBackSpace () abort
  let col = col('.') - 1

  return !col || getline('.')[col - 1] =~# '\s'
endfun

" Deletes code block and removes comma if last element in block
fun! DeleteBlock ()
  norm! $v%Vx

  let curr_char = GetChar(1)

  if match(curr_char, '\w') < 0
    norm! k$x
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
    " call one#highlight('htmlArg', 'b7b7b7', '', '')
    " call one#highlight('htmlTag', 'b7b7b7', '', '')
    " call one#highlight('htmlEndTag', 'b7b7b7', '', '')
  endif
endfun

" Get character at given pos distance away from the cursor
fun! GetChar (pos)
  let this_char = getline(".")[col(".") - a:pos:]

  return strcharpart(this_char, 0, 1)
endfun

" Format single line HTML tags to multi line tags
fun! FormatTag ()
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

    call Find(matched_tag[1:], a:split)
  catch
    echo v:exception
  endtry
endfun

" Search globally for the given selection
fun! SearchSelection ()
  let selected = GetVisual()

  execute 'CtrlSF "' . selected . '"'
endfun

fun! EditVimConf ()
  let conf_choice = confirm("Choose Vim config", "&Vars\n&Utils\n&Mappings\n&Settings\n&Init")

  if conf_choice > 0
    if conf_choice == 5
      execute "e $NVIM_DIR/init.vim"
    else
      execute "e $NVIM_DIR/" . g:imports[conf_choice - 1]
    endif
  endif
endfun

fun! CommitChanges ()
  silent exec "!cd $NVIM_DIR && git add ."

  redraw!

  call inputsave()

  let message = input("Commit message: ")

  call inputrestore()

  silent exec '!cd $NVIM_DIR && git commit -am "' . message . '"'
  silent exec "!cd $NVIM_DIR && git push"

  redraw!

  echo "Committed and pushed"
endfun

fun! SilentExec (cmd)
  let cmd = substitute(a:cmd, "^!", "", "")
  let cmd = substitute(cmd, "%", shellescape(expand("%")), "")

  call system(cmd)
endfun

fun! WriteEmptyJson ()
  norm! $

  let this_char = GetChar(1)
  let prev_char = GetChar(2)

  if this_char == "{"
    norm! O{
    norm! o},

    call feedkeys("O")
  elseif this_char == "}"
    norm! A,
    norm! o{
    norm! o}

    call feedkeys("O")
  elseif prev_char . this_char == "},"
    norm! o{
    norm! o}

    call feedkeys("O")
  else
    echo "Cannot insert here"
  endif
endfun

fun! SelectBlock ()
  let block_end = 0

  norm! $V%

  while block_end == 0
    norm! g_

    if GetChar(1) == "{"
      norm! %
    else
      let block_end = 1
    endif
  endwhile
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

fun! CloseWindow ()
  if (bufnr(".new$") >= 0)
    wincmd l
    bw
    
    MundoToggle
  elseif bufname(".") =~ "__Mundo_"
    MundoToggle
  else
    bw
  endif
endfun

fun! SelShell (cmd)
  let s = @s

  norm! gv"sy

  call setreg('h', system("echo '" . getreg('s') . "' | " . a:cmd))

  norm! gv
  norm! "hp
endfun

fun! FormatJson ()
  call SelShell("jq .")
  call feedkeys('kJ')
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
