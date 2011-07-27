# -*- coding: utf-8 -*-
require "sinatra"
require "sinatra/reloader" if development?
require "instagram"

enable :session

CALLBACK_URL = "http://localhost:4567/oauth/callback" if development?
CALLBACK_URL = "http://atoken4instagram.heroku.com/oauth/callback" if production?

get "/" do
  erb :index
end

post "/oauth/connect" do
  Instagram.configure do |config|
    config.client_id = params[:cid]
    config.client_secret = params[:csecret]
  end
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  @access_token = response.access_token
  erb :callback
end
