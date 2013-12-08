# encoding: utf-8

class Post < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, :presence => true
  validates :body, :presence => true

  # has_many :somethings
  # belongs_to :someotherthing

  scope :published, -> { order("created_at DESC") }

end
