require 'rake/testtask'

Rake::TestTask.new('run_specs') do |t|
  t.pattern = 'spec/niki/**_spec.rb'
  t.libs << ['spec', 'lib/niki/']
end

Rake::TestTask.new('run_features') do |t|
  t.pattern = 'features/**_feature.rb'
  t.libs << ['features/support', 'lib/niki']
end

task :test => [:run_features, :run_specs]

task :run do
  $: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')
  require 'server'
  require 'niki'
  server = Server.new Niki.new
  server.start
end

task :default => :test
