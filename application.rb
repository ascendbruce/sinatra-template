require "sinatra"
require "sinatra/activerecord"
require "sinatra/base"
require "active_record"
require "uri"
require "bundler/setup"
require "logger"
require "erb"

include ERB::Util

if development?
  require "sinatra/reloader"
  also_reload './helpers.rb'
  Dir["./models/*.rb"].each {|file| also_reload file }
  # also_reload './models.rb'
  # also_reload '/path/to/some/file'
  # dont_reload '/path/to/other/file'
end

# App
require "./helpers.rb"
Dir["./models/*.rb"].each {|file| require file }
require "./config/custom.rb"

RACK_ENV ||= ENV["RACK_ENV"] || "development"

dbconfig = YAML.load(File.read("config/database.yml"))
set :database, dbconfig[RACK_ENV]
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))

## app settings

enable :sessions

before '/admin/*' do
  protected!
end

## actions ##

get '/' do
  redirect to('/index')
end

get '/index' do
  @posts = Post.order("created_at DESC").limit(PER_PAGE)
  erb :index
end

get "/show/:id" do
  if (@post = Post.find_by_id(params[:id]))
    erb :show
  else
    redirect to('/')
  end
end

get "/admin/index" do
  @posts = Post.order("created_at DESC").limit(PER_PAGE)
  erb :index
end
