# Knyle Style Sheets

Inspired by [TomDoc](http://tomdoc.org), KSS attempts to provide a methodology for writing maintainable, documented CSS within a team. Specifically, KSS is a CSS structure, documentation specification, and styleguide format. It is **not** a preprocessor, CSS framework, naming convention, or specificity guideline.

## Purpose

KSS is a set of guidelines to help you produce an HTML styleguide tied to CSS documentation that is nice to read in plain text, yet structured enough to be automatically extracted and processed by a machine. It is designed with CSS preprocessors (such as SCSS or LESS) in mind, and flexible enough to accommodate a multitude of CSS frameworks (such as YUI, Blueprint or 960).

KSS focuses on *how people work with CSS* — it does not define code structures, naming conventions, or methods for abstraction. It is important to understand that the styleguide format and documentation format are intrinsically tied to one another.

## CSS Structure

Certain styles must be separated into different folders to use KSS effectively:

* **Preprocessor global variables and helper functions** — These files should not generate any actual CSS.
* **Standalone styles (plugins)** - Self-contained styles that do not depend on any other styles. Examples include: CSS resets, (jQuery) plugin styles, and CSS frameworks.
* **Shared styles** - Styles that are shared across many pages or most of the website. Examples include: form styles, generic text styling, and general layout.

The remainder of your styles can be organized at your discretion.

### Recommended directory structure

    styles
    ├── globals
    │   ├── browser_helpers.scss
    │   ├── responsive_helpers.scss
    │   ├── variables.scss
    ├── plugins
    │   ├── jquery.fancybox-1.3.4.css
    │   ├── pygment_trac.css
    │   └── reset.scss
    ├── sections
    │   ├── feed.scss
    │   ├── ideas.scss
    │   ├── profile.scss
    └── shared
        ├── forms.scss
        └── markdown.scss

## Documentation

Unlike TomDoc, not every CSS rule should be documented. You should document a rule declaration when the rule can accurately describe a visual UI element in the styleguide. Each element should have one documentation block describing that particular UI element's various states.

KSS documentation is hierarchical in nature — any documentation blocks at a styleguide hierarchy apply to the documentation blocks within that level.

### Format

The basic format for KSS documentation can be best explained in an example:

```css
/*
A button suitable for giving stars to someone.

.stars-given - A highlight indicating you've already given a star.
.disabled    - Dims the button to indicate it cannot be used.

Styleguide 2.1.3
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

When using a preprocessor that supports the functionality, use `//` to prefix your comment sections like so (SCSS example):

```scss
// A button suitable for giving stars to someone.
//
// .stars-given - A highlight indicating you've already given a star.
// .disabled    - Dims the button to indicate it cannot be used.
//
// Styleguide 2.1.3
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

### The modifiers section

### The styleguide section

## Styleguide