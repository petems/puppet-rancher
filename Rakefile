require 'puppet-syntax/tasks/puppet-syntax'

desc "Run acceptance tests"
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

PuppetSyntax.future_parser = true
PuppetSyntax.exclude_paths = ["vendor/**/*"]
PuppetSyntax.hieradata_paths = ["**/puppet/etc/**/*.yaml"]
