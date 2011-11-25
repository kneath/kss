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

## Styleguide