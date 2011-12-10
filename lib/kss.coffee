# This class scans your stylesheets for pseudo classes, then inserts a new CSS
# rule with the same properties, but named 'psuedo-class-{{name}}'.
#
# Supported pseudo classes: hover, disabled, active, visited.
#
# Example:
#
#   a:hover{ color:blue; }
#   => a.pseudo-class-hover{ color:blue; }
class KssStateGenerator
  constructor: ->
    pseudos = /(\:hover|\:disabled|\:active|\:visited)/g

    try
      for stylesheet in document.styleSheets
        idxs = []
        for rule, idx in stylesheet.cssRules
          if (rule.type == CSSRule.STYLE_RULE) && pseudos.test(rule.selectorText)
            replaceRule = (matched, stuff) ->
              return ".pseudo-class-" + matched.replace(':', '')
            @insertRule(rule.cssText.replace(pseudos, replaceRule))

  # Takes a given style and attaches it to the current page.
  #
  # rule - A CSS rule String (ex: ".test{ display:none; }").
  #
  # Returns nothing.
  insertRule: (rule) ->
    headEl = document.getElementsByTagName('head')[0]
    styleEl = document.createElement('style')
    styleEl.type = 'text/css'
    if styleEl.styleSheet
      styleEl.styleSheet.cssText = rule
    else
      styleEl.appendChild(document.createTextNode(rule))

    headEl.appendChild(styleEl)

new KssStateGenerator