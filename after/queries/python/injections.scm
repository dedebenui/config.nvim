;; extends

(assignment
  type: (type (identifier) @lang (#eq? @lang "html"))
  right: (string (string_content) @injection.content)
  (#set! injection.language "html")
  (#set! injection.combined)
)



