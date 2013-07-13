# encoding: utf-8

# this is a fetcher for fetching books list into database.
# need to be set in contab
require "active_record"
require "logger"

# App
require_relative "../config/custom.rb"
Dir["./models/*.rb"].each {|file| require file }

RACK_ENV ||= ENV["RACK_ENV"] || "development"
dbconfig = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}-script.log", "a+"))

Post.create(:title => "test", :author => "test", :body => "test test test")
