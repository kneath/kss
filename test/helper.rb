require 'minitest/autorun'
require 'kss'

module Kss
  class Test < Minitest::Test
    def self.test(name, &block)
      define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
    end

    def default_test
    end

    def fixture(name)
      @fixtures ||= {}
      @fixtures[name] ||= File.read("test/fixtures/#{name}")
    end
  end
end