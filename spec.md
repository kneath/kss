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

## Style Documentation

Unlike TomDoc, not every CSS rule should be documented. You should document a rule declaration when the rule can accurately describe a visual UI element in the styleguide. Each element should have one documentation block describing that particular UI element's various states.

KSS documentation is hierarchical in nature — any documentation blocks at a styleguide hierarchy apply to the documentation blocks within that level.

### Format

The basic format for KSS documentation can be best explained in an example:

```css
/*
A button suitable for giving stars to someone.

:hover             - Subtle hover highlight.
.stars-given       - A highlight indicating you've already given a star.
.stars-given:hover - Subtle hover highlight on top of stars-given styling.
.disabled          - Dims the button to indicate it cannot be used.

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
// :hover             - Subtle hover highlight.
// .stars-given       - A highlight indicating you've already given a star.
// .stars-given:hover - Subtle hover highlight on top of stars-given styling.
// .disabled          - Dims the button to indicate it cannot be used.
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

The description should be plain sentences of what the CSS rule or hierarchy does and looks like. A good description gives guidance toward the application of elements the CSS rules style.

CSS rules that depend on specific HTML structures should describe those structures using `<element#id.class:pseudo>` notation. For example:

```scss
// A feed of activity items. Within a <section.feed>, there should be many
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

// :hover             - Subtle hover highlight.
// .stars-given       - A highlight indicating you've already given a star.
// .stars-given:hover - Subtle hover highlight on top of stars-given styling.
// .disabled          - Dims the button to indicate it cannot be used.

### The styleguide section

## Preprocessor Variable Documentation

## Preprocessor Helper Documentation

## Styleguide