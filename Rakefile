require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: %w[spec]

task :win_binary do
  ruby "ocran --gem-full ./bin/arma-tvt-loadouts.rb"
end