require File.dirname(__FILE__) + '/lib/kss/version'

Gem::Specification.new do |s|
  s.name              = "kss"
  s.version           = Kss::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A library for parsing KSS documented stylesheets and generating styleguides"
  s.homepage          = "http://github.com/kneath/kss"
  s.email             = "kneath@gmail.com"
  s.authors           = [ "Kyle Neath" ]
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("test/**/*")

  s.description       = <<desc
  Inspired by TomDoc, KSS attempts to provide a methodology for writing
  maintainable, documented CSS within a team. Specifically, KSS is a CSS
  structure, documentation specification, and styleguide format.

  This is a ruby library for parsing KSS documented CSS and generating
  styleguides.
desc
end