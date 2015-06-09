require 'bundler/gem_tasks'
require_relative 'lib/lazy_warrior/lazy_config.rb'

# Setup RSpec task.
# Can be used with `rake spec`
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts 'Cannot find RSpec in current environment.'
end

desc 'Open an irb session preloaded with this library'
task :console do
    sh 'irb -rubygems -I lib -r lazy_warrior.rb'
end

desc 'Display config help'
task :config do
  LazyConfig.usage
end

