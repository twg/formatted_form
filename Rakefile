begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "bootstrap_builder"
    gem.homepage    = "http://github.com/twg/bootstrap_builder"
    gem.license     = "MIT"
    gem.summary     = "A Rails form builder that generates Twitter Bootstrap markup and helps keep your code clean"
    gem.description = ''
    gem.email       = "jack@twg.ca"
    gem.authors     = ["Jack Neto", 'The Working Group Inc.']
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end