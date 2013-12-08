require File.dirname(__FILE__) + "/spec_helper"

describe "Application" do
  def app
    @app ||= Sinatra::Application
  end

  context "basic http" do
    it "should return 404 status when page cannot be found" do
      get "/page_not_found"
      last_response.status.should == 404
    end

    it "should reutrn 200 status to index" do
      get "/index"
      last_response.should be_ok
    end

    it "should reutrn 200 status to show" do
      Post.create(:title=>"test", :author => "test", :body => "test")
      get "/show/1"
      last_response.should be_ok
    end

    it "should be 401 with bad credentials" do
      authorize "admin", "wrong_password"
      get "/admin/index"
      last_response.status.should == 401
    end

    it "should be 200 with good credentials" do
      authorize HTTP_AUTH_USERNAME, HTTP_AUTH_PASSWORD
      get "/admin/index"
      last_response.should be_ok
    end

  end
end
