# encoding: utf-8

class Post < ActiveRecord::Base
  validates :title,  :presence => true
  validates :author, :presence => true
  validates :body,   :presence => true
end
