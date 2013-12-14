RACK_ENV = "test"

require_relative "../application.rb"
require "rspec"
require "rack/test"

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include RSpecMixin
end
