; Highlight HTML inside the `view!` macro
((macro_invocation
  (identifier) @macro_name (#eq? @macro_name "view")
  (token_tree) @html_content)
 (#set! injection.language "html"))
