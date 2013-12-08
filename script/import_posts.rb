# encoding: utf-8

require_relative "../application.rb"

# require "open-uri"
# require "nokogiri"

settings.logger.info "=== running #{__FILE__} ==="

10.times do |i|
  post = Post.create(
    :title => "Lorem ipsum dolor sit amet... #{i}",
    :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  )
  settings.logger.info post.inspect
end

settings.logger.info "=== finished #{__FILE__} ==="
