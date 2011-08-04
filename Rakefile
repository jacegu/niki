require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**_spec.rb'
  t.libs << ['spec', 'lib']
  t.verbose = true
end

task :run do
  $: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')
  require 'server'
  require 'niki'
  server = Server.new Niki.new
  server.start
end

task :default => :test
