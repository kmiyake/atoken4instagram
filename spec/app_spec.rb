require File.join(File.dirname(__FILE__), "spec_helper")

describe Atoken4Instagram do

  describe "/" do
    it "should be success" do
      get '/'
      last_response.status.should == 200
    end

    it "should include cid input box" do
      get '/'
    end
  end

  describe "/oauth/connect" do
    it "should redirect to / without params[:cid]" do
      post '/oauth/connect', params = { :cid => "", :csecret => "csecret" }
      last_response.should be_redirect
      URI.parse(last_response.header['Location']).path.should == '/'
    end

    it "should redirect to / without params[:csecret]" do
      post '/oauth/connect', params = { :cid => "cid", :csecret => "" }
      last_response.should be_redirect
      URI.parse(last_response.header['Location']).path.should == '/'
    end

    it "should redirect to / without params[:cid] and params[:csecret]" do
      post '/oauth/connect', params = { :cid => "", :csecret => "" }
      last_response.should be_redirect
      URI.parse(last_response.header['Location']).path.should == '/'
    end
  end
end
