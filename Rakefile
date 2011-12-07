require 'rake'
require 'rake/testtask'
require 'bundler/setup'
Bundler.require

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'logging'
include Logging
require 'db_base'
require 'zipcode'

ENV['SCRIPT_ENV'] ||= 'development'

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
    logfiles = Dir.entries(dir + '/log').select { |f| f =~ /log$/ }
    logfiles.each { |f| File.truncate("#{dir}/log/#{f}", 0) }
  end
end

namespace :db do
  desc "Truncate the zipcode table"
  task :truncate do
    logger.debug 'Truncate called from rake'
    ZipCode.delete_all
  end
end
