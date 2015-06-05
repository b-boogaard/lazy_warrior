require 'bundler/gem_tasks'
require 'rake/testtask'
require_relative 'lib/lazy_warrior/lazy_config.rb'

desc 'Display config help'
task :config do
  LazyConfig.new.usage
end

Rake::TestTask.new do |t|
  t.libs << 'spec'
end
