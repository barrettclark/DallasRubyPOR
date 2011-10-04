require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*test.rb']
  t.warning = true
  t.verbose = true
end

desc "rake test is the default action."
task :default => :test

desc "this is a test"
task :testing_rake do
  puts "Hello from rake!"
end

namespace :log do
  desc "Clear log files"
  task :clear do
    dir = File.dirname(__FILE__)
    logfiles = Dir.entries(dir + '/logs').select { |f| f =~ /log$/ }
    logfiles.each { |f| File.truncate("#{dir}/logs/#{f}", 0) }
  end
end
