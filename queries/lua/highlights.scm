; extends

((identifier) @namespace.builtin
  (#eq? @namespace.builtin "vim"))

(("<="  @operator.) (#set! conceal "≤"))
((">="  @operator.) (#set! conceal "≥"))
(("~="  @operator.) (#set! conceal "≠"))
