require File.dirname(__FILE__) + "/spec_helper"

describe Post do
  it "should validate presence" do
    s = Post.new
    s.should_not be_valid
  end

  it "should be created with valid attributes" do
    v = Post.new(:title => 'some', :author => 'some', :body => "some some")
    v.should be_valid
  end
end
