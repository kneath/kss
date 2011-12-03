// Creates dummy duplicate styles for pseudo-classes like :hover and :disabled
// automatically from your stylesheets.
(function() {
  var disabled, duplicateRule, hover, idx, idxs, rule, stylesheet, _i, _len, _len2, _ref, _ref2;

  duplicateRule = function(rule) {
    var headEl, styleEl;
    headEl = document.getElementsByTagName('head')[0];
    styleEl = document.createElement('style');
    styleEl.type = 'text/css';
    if (styleEl.styleSheet) {
      styleEl.styleSheet.cssText = rule;
    } else {
      styleEl.appendChild(document.createTextNode(rule));
    }
    return headEl.appendChild(styleEl);
  };

  hover = /:hover/;

  disabled = /:disabled/;

  try {
    _ref = document.styleSheets;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      stylesheet = _ref[_i];
      idxs = [];
      _ref2 = stylesheet.cssRules;
      for (idx = 0, _len2 = _ref2.length; idx < _len2; idx++) {
        rule = _ref2[idx];
        if (rule.type === CSSRule.STYLE_RULE && (hover.test(rule.selectorText) || disabled.test(rule.selectorText))) {
          duplicateRule(rule.cssText.replace(':', '.pseudo-class-'));
        }
      }
    }
  } catch (_error) {}

}).call(this);