require 'rake'
require 'fileutils'
$LOAD_PATH << File.expand_path("lib/", __FILE__)
require File.dirname(__FILE__) + '/lib/shellac/version'

desc 'Run tests'
task :test do
  sh 'rspec spec/'
end


desc 'Build gem'
task :build do
  sh 'gem build shellac.gemspec'
  gem_file = "shellac-#{Shellac::VERSION}.gem"
  FileUtils.mkdir_p 'gems'
  FileUtils.mv gem_file, 'gems', :force => true
end

task :default => :test
