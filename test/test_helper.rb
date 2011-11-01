require 'pp'
require 'rubygems'
require 'bundler/setup'
Bundler.require

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
ENV['SCRIPT_ENV'] ||= 'test'

require 'db_base'
