# encoding: utf-8

require "rubygems"
require "bundler"
Bundler.require(:default)
Bundler.require(:default, settings.environment)

require "log4r/yamlconfigurator"
include Log4r

include ERB::Util

=begin
#########  #########  ########## ##########   ##   ##      ##   #######   #########
##         ##             ##         ##       ##   ####    ##  ##     ##  ##
##         ##             ##         ##       ##   ## ##   ##  ##         ##
#########  #########      ##         ##       ##   ##  ##  ##  ##   ####  #########
       ##  ##             ##         ##       ##   ##   ## ##  ##     ##         ##
       ##  ##             ##         ##       ##   ##    ####  ##     ##         ##
#########  #########      ##         ##       ##   ##      ##   #######   #########
=end

set :root, File.expand_path(File.dirname(__FILE__))

# Application Settings
config_file "#{settings.root}/config/application.yml"
config_file "#{settings.root}/config/confidential.yml"

if settings.development?
  require "sinatra/reloader"
  also_reload "#{settings.root}/helpers.rb"
  Dir["#{settings.root}/models/*.rb"].each { |file| also_reload file }
end

# Timezone
ENV["TZ"] = settings.default_timezone
ActiveRecord::Base.time_zone_aware_attributes = true

# Database
dbconfig = YAML.load(File.read("config/database.yml")).with_indifferent_access
set :database, dbconfig[settings.environment]
ActiveRecord::Base.establish_connection dbconfig[settings.environment]

# Logger
Dir.mkdir("log") if !File.exists?("log") || !File.directory?("log")
ActiveRecord::Base.logger = Logger.new(File.open("log/#{settings.environment}.log", "a+"))

Log4r::YamlConfigurator["HOME"] = "#{settings.root}/log"
Log4r::YamlConfigurator.load_yaml_file "config/log4r.yml"
set :logger, Log4r::Logger["info_logger"]

# Models and Heplers (Models must go after DB connection)
require "#{settings.root}/helpers.rb"
Dir["#{settings.root}/models/*.rb"].each { |file| require file }

## app settings

enable :sessions

=begin
    ###      #######   #######
   ## ##     ##    ##  ##    ##
  ##   ##    ##    ##  ##    ##
 #########   #######   #######
##       ##  ##        ##
##       ##  ##        ##
=end

before "/admin/*" do
  protected!
end

not_found do
  erb :not_found
end

## actions ##

get "/" do # redirect / to /index can avoid link to wrong path if you are putting your app on a sub-path
  redirect to("/index")
end

get "/index" do
  @posts = Post.published
  erb :posts
end

get "/posts" do
  @posts = Post.published
  erb :posts
end

get "/posts/:id" do
  if @post = Post.find_by_id(params[:id])
    erb :post
  else
    status 404
  end
end

get "/posts.rss" do
  @posts = Post.published
  builder :posts
end
