require "rack/test"
require "rspec"
require File.join(File.dirname(__FILE__), "..", "app")

module SpecHelper
  def app
    Atoken4Instagram.new
  end
end

set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include SpecHelper
end
