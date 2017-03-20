require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_spec.rb']


task :default => :rspec