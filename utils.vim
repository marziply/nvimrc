command! -nargs=1 Cman :vert Man 3 <args>
command! -nargs=1 Silent call SilentExec(<q-args>)

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string = a:string
  let string = escape(string, '^$.*\/~[]')
  let string = substitute(string, '\n', '\\n', "g")

  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual () range
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard

  set clipboard&
  normal! ""gvy

  let selection = getreg('"')

  call setreg('"', reg_save, regtype_save)

  let &clipboard = cb_save
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Find file in current directory and edit it
" https://vim.fandom.com/wiki/Find_files_in_subdirectories
function! Find (name)
  let l:list = system("find . -name '" . a:name . "' | perl -ne 'print \"$.\t\$_\"'")
  let l:num = strlen(substitute(l:list, "[^\n]", "", "g"))

  if l:num < 1
    echo "'" . a:name . "' not found"

    return
  endif

  if l:num != 1
    echo l:list
    
    try
      let l:input = nr2char(getchar())
    catch
      redraw!

      echo "Cancelled"

      return
    endtry

    if strlen(l:input) == 0 | return | endif
    
    if strlen(substitute(l:input, "[0-9]", "", "g")) > 0
      echo "Not a number"
    
      return
    endif
    
    if l:input < 1 || l:input > l:num
      echo "Out of range"
    
      return
    endif

    let l:line = matchstr("\n" . l:list, "\n" . l:input . "\t[^\n]*")
  else
    let l:line = l:list
  endif

  let l:line = substitute(l:line, "^[^\t]*\t./", "", "")

  redraw!

  echo l:line

  execute ":e ".l:line
endfunction

function! FindNew (name)
  let list = system("find . -name '" . a:name)
endfunction

" COC method for checking if previous character is a space
function! CheckBackSpace () abort
  let col = col('.') - 1

  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Deletes code block and removes comma if last element in block
function! DeleteBlock ()
  normal! $v%Vx

  let curr_char = GetChar(1)

  if match(curr_char, '\w') < 0
    normal! k$x
  endif
endfunction

" Set custom 'one' colourscheme colours
function! SetColours ()
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
endfunction

" Get character at given pos distance away from the cursor
function! GetChar (pos)
  let this_char = getline(".")[col(".") - a:pos:]

  return strcharpart(this_char, 0, 1)
endfunction

" Format single line HTML tags to multi line tags
function! FormatTag ()
  let l:end_keys = "i\r\<esc>$"

  normal! ^

  SplitjoinSplit
  SplitjoinSplit

  " normal! %
  call feedkeys("%")

  " let l:this_line = trim(getline("."))
  " 
  " if GetChar(1) == "/" | call feedkeys("hhx") | endif

  call feedkeys("Y\<cr>")
  " if GetChar(1) == ">" && l:this_line[0] == "<"
  "   SplitjoinSplit
  " 
  "   call feedkeys("^%")
  " 
  "   let l:end_keys = l:end_keys . "gJ$"
  " else
  " endif
  " 
  " call feedkeys(l:end_keys)
endfunction

function! MatchTag ()
  let this_line = getline('.')
  let matched_tag = matchstr(this_line, '<[A-Za-z-]\+')

  if empty(matched_tag)
    throw "No matches"
  else
    return matched_tag
  endif
endfunction

" Search globally for either tag on given line or from the filename
function! SearchTag (search_dir)
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
endfunction

function! GoToTag ()
  try
    let matched_tag = MatchTag()
    let file_name = matched_tag[1:] . ".vue"

    call Find(file_name)
  catch
    echo v:exception
  endtry
endfunction

" Search globally for the given selection
function! SearchSelection ()
  let selected = GetVisual()

  execute 'CtrlSF "' . selected . '"'
endfunction

function! EditVimConf ()
  let conf_choice = confirm("Choose Vim config", "&Vars\n&Utils\n&Mappings\n&Settings\n&Init")

  if conf_choice > 0
    if conf_choice == 5
      execute "e $NVIM_DIR/init.vim"
    else
      execute "e $NVIM_DIR/" . g:imports[conf_choice - 1]
    endif
  endif
endfunction

function! CommitChanges ()
  silent exec "!cd $NVIM_DIR && git add ."

  redraw!

  call inputsave()

  let message = input("Commit message: ")

  call inputrestore()

  silent exec '!cd $NVIM_DIR && git commit -am "' . message . '"'
  silent exec "!cd $NVIM_DIR && git push"

  redraw!

  echo "Commited and pushed"
endfunction

function! SilentExec (cmd)
  let cmd = substitute(a:cmd, "^!", "", "")
  let cmd = substitute(cmd, "%", shellescape(expand("%")), "")

  call system(cmd)
endfunction

function! ChangeDirectory (init)
  if has('gui_running')
    let dirs = ["~/dev/pollen8-discover", "~/dev/pollen8-platform-customer", "~/dev/pollen8-backend-v2"]

    if a:init && getcwd() != $HOME | return | endif

    let dir_choice = confirm("Choose directory", "&Discover\n&Platform\n&Node\n&Other")

    if dir_choice == 0 || dir_choice == 4
      redraw

      call inputsave()

      let directory = input("Directory: ", "", "dir")

      call inputrestore()
    else
      let directory = dirs[dir_choice - 1]
    endif

    try
      exec "cd " . directory

      echo directory
    catch
      redraw

      echo "Directory not found\n"

      call ChangeDirectory(a:init)
    endtry
  endif
endfunction

function! WriteEmptyJson ()
  normal! $

  let this_char = GetChar(1)
  let prev_char = GetChar(2)

  if this_char == "{"
    normal! O{
    normal! o},

    call feedkeys("O")
  elseif this_char == "}"
    normal! A,
    normal! o{
    normal! o}

    call feedkeys("O")
  elseif prev_char . this_char == "},"
    normal! o{
    normal! o}

    call feedkeys("O")
  else
    echo "Cannot insert here"
  endif
endfunction

function! SelectBlock ()
  let block_end = 0

  normal! $V%

  while block_end == 0
    normal! g_

    if GetChar(1) == "{"
      normal! %
    else
      let block_end = 1
    endif
  endwhile
endfunction

function! FoldAllBlocks ()
  let this_line = line(".")
  let matched = 1

  normal! gg

  while matched > 0
    let matched = search(g:block_reg, "eW")

    normal! V%zfj
    execute "normal! \<esc>"
  endwhile

  execute this_line

  normal! zz
endfunction

function! CloseWindow ()
  if (bufnr(".new$") >= 0)
    wincmd l
    bw
    
    MundoToggle
  elseif bufname(".") =~ "__Mundo_"
    MundoToggle
  else
    bw
  endif
endfunction

function! SelShell (cmd)
  let s = @s

  normal! gv"sy

  call setreg('h', system("echo '" . getreg('s') . "' | " . a:cmd))

  norm! gv
  norm! "hp
endfunction

function! FormatJson ()
  call SelShell("jq .")
  call feedkeys('kJ')
endfunction
