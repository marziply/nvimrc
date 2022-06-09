" 1

com! -nargs=0 -range Vcp norm! gv"ay
com! -nargs=1 -complete=buffer Vsb vert sb <args>
com! -nargs=1 Cman vert Man 3 <args>

" Searchs globally in the current directory byt he currently selected text
fun! VisualSearch (num, chars = '')
  exec 'Vcp'

  call feedkeys(':%s/' . @a . '//g' . a:chars)

  " Moves the cursor left `num` times such that subsequent key presses are
  " for the replacement section of the command
  for i in range(0, a:num)
    call feedkeys("\<left>")
  endfor
endfun

" Formats JavaScript objects to raw JSON
fun! FormatJSON ()
  let @b = system('node -p "JSON.stringify(' . @a . ')"')
  let @c = system('jq', getreg('b'))

  norm! gv
  norm! "cp
endfun

" Folds all available code blocks within the current buffer
fun! FoldAllBlocks ()
  let this_line = line(".")
  let matched = 1

  norm! gg

  while matched > 0
    let matched = search(g:block_reg, "eW")

    norm! V%zfj

    exec "norm! \<esc>"
  endwhile

  exec this_line

  norm! zz
endfun

" Handles whitespace in CoC dropdown suggestion list
fun! HandleWhitespace ()
  let l:col = col('.') - 1
  let l:line = getline('.')

  if !l:col || l:line[l:col - 1] =~# '\s'
    return "\<tab>"
  else
    return coc#refresh()
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

  if exists(':AirlineRefresh')
    AirlineRefresh
  endif
endfun

fun! Configure (files)
  let l:names = a:files
    \ ->copy()
    \ ->map("v:val->split('/')->get(-1)->split('\\.')->get(0)")
    " \ ->map("v:val->matchstr(':[word]:\\.vim')")
  let l:choices = l:names
    \ ->copy()
    \ ->map('"&" . v:val')
    \ ->join("\n")
  let l:sel = confirm("choose config", l:choices) - 1

  if l:sel >= 0
    exec "e" . a:files->get(l:sel)
  endif
endfun

" Edit a selected Vim config file
fun! ConfigureNvim ()
  let l:files = g:modules->add(expand('$NVIM_DIR/init.vim'))

  call Configure(l:files)
endfun

" Edit a selected Vim config file
fun! ConfigureZsh ()
  let l:names = [
    \ 'aliases',
    \ 'env',
    \ 'init',
    \ 'login',
    \ 'theme',
    \ 'utils'
  \]
  let l:files = l:names
    \ ->copy()
    \ ->map('expand(printf("$ZSH_DIR/%s.zsh", v:val))')

  call Configure(l:files)
endfun

" Commits and pushes all tracked changes to the Vim config files
fun! CommitAndPush ()
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

" Toggles relative line numbers to make movements up and down easier
fun! ToggleRelative ()
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
