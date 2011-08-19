require 'rake/testtask'

Rake::TestTask.new('specs') do |t|
  t.pattern = 'spec/niki/*_spec.rb'
  t.libs << ['spec', 'lib/niki']
end

Rake::TestTask.new('features') do |t|
  t.pattern = 'features/*_feature.rb'
  t.libs << ['features/support', 'lib/niki']
end

task :test => [:features, :specs]

task :run do
  $: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')
  require 'niki/server'
  require 'niki/wiki'
  server = Niki::Server.new(Niki::Wiki.new)
  server.start
end

task :default => :test
