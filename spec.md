# Knyle Style Sheets

Inspired by [TomDoc](http://tomdoc.org), KSS attempts to provide a methodology for writing maintainable, documented CSS within a team. Specifically, KSS is a documentation specification and styleguide format. It is **not** a preprocessor, CSS framework, naming convention, or specificity guideline.

## Purpose

KSS is a set of guidelines to help you produce an HTML styleguide tied to CSS documentation that is nice to read in plain text, yet structured enough to be automatically extracted and processed by a machine. It is designed with CSS preprocessors (such as SCSS or LESS) in mind, and flexible enough to accommodate a multitude of CSS frameworks (such as YUI, Blueprint or 960).

KSS focuses on *how people work with CSS* — it does not define code structures, naming conventions, or methods for abstraction. It is important to understand that the styleguide format and documentation format are intrinsically tied to one another.

## Style Documentation

Unlike TomDoc, not every CSS rule should be documented. You should document a rule declaration when the rule can accurately describe a visual UI element in the styleguide. Each element should have one documentation block describing that particular UI element's various states.

KSS documentation is hierarchical in nature — any documentation blocks at a styleguide hierarchy apply to the documentation blocks within that level. This means that documentation for 2.1 applies to documentation for 2.1.3.

### Format

The basic format for KSS documentation can be best explained in an example:

```css
/*
A button suitable for giving stars to someone.

:hover             - Subtle hover highlight.
.stars-given       - A highlight indicating you've already given a star.
.stars-given:hover - Subtle hover highlight on top of stars-given styling.
.disabled          - Dims the button to indicate it cannot be used.

Styleguide 2.1.3.
*/
a.button.star{
  ...
}
a.button.star.stars-given{
  ...
}
a.button.star.disabled{
  ...
}
```

When using a preprocessor that supports the functionality, use `//` to prefix your comment sections (SCSS example):

```scss
// A button suitable for giving stars to someone.
//
// :hover             - Subtle hover highlight.
// .stars-given       - A highlight indicating you've already given a star.
// .stars-given:hover - Subtle hover highlight on top of stars-given styling.
// .disabled          - Dims the button to indicate it cannot be used.
//
// Styleguide 2.1.3.
a.button.star{
  ...
  &.star-given{
    ...
  }
  &.disabled{
    ...
  }
}
```

Each KSS documentation block consists of three parts: a description of what the element does or looks like, a list of modifier classes or pseudo-classes and how they modify the element, and a reference to the element's position in the styleguide.

### The description section

The description should be plain sentences of what the CSS rule or hierarchy does and looks like. A good description gives guidance toward the application of elements the CSS rules style.

CSS rules that depend on specific HTML structures should describe those structures using `<element#id.class:pseudo>` notation. For example:

```scss
// A feed of activity items. Within each <section.feed>, there should be many
// <article>s which are the  feed items.
```

To describe the status of a set of rules, you should prefix the description with **Experimental** or **Deprecated**.

**Experimental** indicates CSS rules that apply to experimental styling. This can be useful when testing out new designs before they launch (staff only), alternative layouts in A/B tests, or beta features.

```scss
// Experimental: An alternative signup button styling used in AB Test #195.
```

**Deprecated** indicates that the rule is slated for removal. Rules that are deprecated should not be used in future development. This description should explain what developers should do when encountering this style.

```scss
// Deprecated: Styling for legacy wikis. We'll drop support for these wikis on
// July 13, 2007.
```

### The modifiers section

If the UI element you are documenting has multiple states or styles depending on added classes or pseudo-classes, you should document them in the modifiers section.

```scss
// :hover             - Subtle hover highlight.
// .stars-given       - A highlight indicating you've already given a star.
// .stars-given:hover - Subtle hover highlight on top of stars-given styling.
// .disabled          - Dims the button to indicate it cannot be used.
```

### The styleguide section

If the UI element you are documenting has an example in the styleguide, you should reference it using the "Styleguide [ref]" syntax.

```scss
// Styleguide 2.1.3.
```

References should be integer sections separated by periods. Each period denotes a hierarchy of the styleguide. Styleguide references can point to entire sections, a portion of the section, or a specific example.

If there is no example, then you must note that there is no reference.

```scss
// No styleguide reference.
```

## Preprocessor Helper Documentation

If you use a CSS preprocessor like SCSS or LESS, you should document all helper functions (sometimes called mixins).

```scss
// Creates a linear gradient background, from top to bottom.
//
// $start - The color hex at the top.
// $end   - The color hex at the bottom.
//
// Compatible in IE6+, Firefox 2+, Safari 4+.
@mixin gradient($start, $end){
  background:$start;
  filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0, startColorstr='$start', endColorstr='$end');
  background:-webkit-gradient(linear, left top, left bottom, from($start), to($end));
  background:-moz-linear-gradient(top,  $start,  $end);
}
```

Each documentation block should have a description section, parameters section, and compatibility section.  The description section follows the same guidelines as style documentation.

### The parameters section

If the mixin takes parameters, you should document each parameter and describe what sort of input it expects (hex, number, etc).

```scss
// $start - The color hex at the top.
// $end   - The color hex at the bottom.
```

### The compatibility section

You must list out what browsers this helper method is compatible in.

```scss
// Compatible in IE6+, Firefox 2+, Safari 4+.
```

If you do not know the compatibility, you should state as such.

```scss
// Compatibility untested.
```

## Styleguide

In order to fully take advantage of KSS, you should create a living styleguide. A living styleguide is a *part of your application* and includes all of the CSS, Javascript, and layout the rest of your application does.

### Organization

The styleguide should be organized by numbered sections. These sections can go as deep as you like. Every element should have a numbered section to refer to. For example:

    1. Buttons
      1.1 Form Buttons
        1.1.1 Generic form button
        1.1.2 Special form button
      1.2 Social buttons
      1.3 Miscelaneous buttons
    2. Form elements
      2.1 Text fields
      2.2 Radio and checkboxes
    3. Text styling
    4. Tables
      4.1 Number tables
      4.2 Diagram tables

The goal here is to create an organizational structure that is flexible, while still rigid enough to be machine processed and referenced inside of documentation.

### Example

This styleguide is automatically generated from KSS documentation using the ruby library.

![](http://share.kyleneath.com/captures/Styleguide_-_GitHub_Team-20111202-160539.png)

The actual templates generating the styleguide just reference the Styleguide section and example HTML. The modified states are generated automatically.

Overall, keep in mind that styleguides should adapt to the application they are referencing and be easy to maintain and as automatic as possible.
