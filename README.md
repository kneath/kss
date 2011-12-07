# Knyle Style Sheets

Inspired by [TomDoc](http://tomdoc.org), KSS attempts to provide a methodology for writing maintainable, documented CSS within a team. Specifically, KSS is a documentation specification and styleguide format. It is **not** a preprocessor, CSS framework, naming convention, or specificity guideline.

* **[The Spec (What KSS is)](https://github.com/kneath/kss/blob/master/SPEC.md)**
* **[Example living styleguide](https://github.com/kneath/kss/tree/master/example)**

## KSS in a nutshell

The methodology and ideas behind Knyle Style Sheets are contained in [SPEC.md](https://github.com/kneath/kss/blob/master/SPEC.md). At it's core, KSS is a documenting syntax for CSS.

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

## Ruby Library

This repository includes a ruby library suitable for parsing SASS, SCSS, and CSS documented with KSS guidelines. To use the library, include it in your project as a gem from <https://rubygems.org/gems/kss>. Then, create a parser and explore your KSS.

```ruby
styleguide = Kss::Parser.new("#{RACK_ROOT}public/stylesheets")

styleguide.section('2.1.1')
# => <Kss::Section>

styleguide.section('2.1.1').description
# => "A button suitable for giving stars to someone."

styleguide.section('2.1.1').modifiers.first
# => <Kss::Modifier>

styleguide.section('2.1.1').modifiers.first.name
# => ':hover'

styleguide.section('2.1.1').modifiers.first.class_name
# => 'pseudo-class-hover'

styleguide.section('2.1.1').modifiers.first.description
# => 'Subtle hover highlight'

```

The library is also fully TomDoc'd, completing the circle of life.

## Generating styleguides

The documenting syntax and ruby library are intended to generate styleguides automatically. To do this, you'll need to leverage a small javascript library that generates class styles for pseudo-class styles (`:hover`, `:disabled`, etc).

* [kss.coffee](https://github.com/kneath/kss/blob/master/lib/kss.coffee)
* [kss.js](https://github.com/kneath/kss/blob/master/lib/kss.js) (compiled js)

For an example of how to generate a styleguide, check out the [`example`](https://github.com/kneath/kss/tree/master/example) sinatra application.

## Development

To hack on KSS, you'll need to install dependencies with `bundle install`. Run tests with `rake`.

To make your life easier, I suggest `bundle install --binstubs` and adding `bin/` to your `$PATH`. If you don't understand this, just blindly add `bundle exec` in front of everything you'd normally do, like `bundle exec rake`.

I apologize on behalf of the Ruby community for this, it's embarrassing and disappointing that dependency management is still so clumsy.