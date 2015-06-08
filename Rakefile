require 'bundler/gem_tasks'
require 'rake/testtask'
require_relative 'lib/lazy_warrior/lazy_config.rb'

desc "Open an irb session preloaded with this library"
task :console do
    sh 'irb -rubygems -I lib -r lazy_warrior.rb'
end

desc 'Display config help'
task :config do
  LazyConfig.usage
end

Rake::TestTask.new do |t|
  t.libs << 'spec'
end
