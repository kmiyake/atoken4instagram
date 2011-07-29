# -*- coding: utf-8 -*-
require "sinatra"
require "sinatra/reloader" if development?
require "instagram"

class Atoken4Instagram < Sinatra::Base
  enable :session

  CALLBACK_URL = 
    case true
    when development?
      "http://localhost:4567/oauth/callback"
    when production?
      "http://atoken4instagram.heroku.com/oauth/callback"
    else
      ""
    end

  get "/" do
    erb :index
  end

  post "/oauth/connect" do
    redirect '/' if params[:cid].empty? || params[:csecret].empty?
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
end
