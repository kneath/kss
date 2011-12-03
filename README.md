# Knyle Style Sheets

This is a ruby library for parsing KSS documented stylesheets and generating styleguides.

Inspired by [TomDoc](http://tomdoc.org), KSS attempts to provide a methodology for writing maintainable, documented CSS within a team. Specifically, KSS is a CSS structure, documentation specification, and styleguide format. It is **not** a preprocessor, CSS framework, naming convention, or specificity guideline.

## Spec

If you would like to learn more about the methodology and ideas behind Knyle Style Sheets, you should read SPEC.md. It contains the documenting syntax and styleguide guidelines.

## Ruby Library

This repository includes a ruby library suitable for parsing SASS, SCSS, and CSS documented with KSS guidelines.

To use the library, include it in your project as a gem from <https://rubygems.org/gems/kss>. Then, create a parser and explore your KSS.

Example with documentation from SPEC.md:

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

styleguide.section('2.1.1').modifiers.first.first.description
  # => 'Subtle hover highlight'

```

For an example of how to use the library to generate a styleguide automatically, check out the `example` folder for a sinatra app with a generated styleguide.

The library is also fully TomDoc'd, completing the circle of life.

## Development

To hack on KSS, you'll need to install dependencies with `bundle install`. Run tests with `rake`.

To make your life easier, I suggest `bundle install --binstubs` and adding `bin/` to your `$PATH`. If you don't understand this, just blindly add `bundle exec` in front of everything you'd normally do, like `bundle exec rake`.

I apologize on behalf of the Ruby community for this, it's embarrassing and disappointing that dependency management is still so clumsy.