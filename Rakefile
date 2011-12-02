require 'rake/testtask'

task :default => :test

def command?(command)
  system("type #{command} > /dev/null 2>&1")
end

#
# Tests
#

if command? :turn
  desc "Run tests"
  task :test do
    suffix = "-n #{ENV['TEST']}" if ENV['TEST']
    sh "turn -Ilib:. test/*.rb #{suffix}"
  end
else
  Rake::TestTask.new do |t|
    t.libs << 'lib'
    t.libs << '.'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = false
  end
end

#
# Development
#

desc "Drop to irb."
task :console do
  exec "irb -I lib -rkss"
end

#
# Gems
#

begin
  require 'kss/version'
  require 'mg'
  MG.new("kss.gemspec")

  desc "Push a new version to Gemcutter and publish docs."
  task :publish => "gem:publish" do
    require File.dirname(__FILE__) + '/lib/kss/version'

    sh "git tag v#{Kss::VERSION}"
    sh "git push origin master --tags"
    sh "git clean -fd"
  end
rescue LoadError
  warn "mg not available."
  warn "Install it with: gem install mg"
end