ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'tilt/erb'

DatabaseCleaner.strategy = :truncation, { except: %w[public.schema_migrations] }

Capybara.app = TrafficSpy::Server

class Minitest::Test

  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
    "identifier"=>"jumpstartlab"}
  end

  def payload_2
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 12:24:28 -0700\",\"respondedIn\":45,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
    "identifier"=>"jumpstartlab"}
  end

  def unregistered_payload
    {"payload"=>
     "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"}
  end

  def nil_payload
    {"payload"=> nil}
  end

  def empty_payload
    {"payload"=> {}}
  end

end

class FeatureTest < Minitest::Test
  include Capybara::DSL

  def setup
    post '/sources', {"identifier" => "JumpstartLabs", "rootUrl" => "http://jumpstartlab.com"}
    post '/sources/JumpstartLabs/data', {"payload"=>
               "{\"url\":\"http://jumpstartlab.com/blog\",
               \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
               \"respondedIn\":37,
               \"referredBy\":\"http://jumpstartlab.com\",
               \"requestType\":\"GET\",
               \"parameters\":[],
               \"eventName\":\"socialLogin\",
               \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
               \"resolutionWidth\":\"1920\",
               \"resolutionHeight\":\"1280\",
               \"ip\":\"63.29.38.211\"}",
               "identifier"=>"JumpstartLabs"}
    post '/sources/JumpstartLabs/data', {"payload"=>
               "{\"url\":\"http://jumpstartlab.com/blog\",
               \"requestedAt\":\"2013-02-16 12:38:28 -0700\",
               \"respondedIn\":67,
               \"referredBy\":\"http://jumpstartlab.com\",
               \"requestType\":\"GET\",
               \"parameters\":[],
               \"eventName\":\"socialLogin\",
               \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
               \"resolutionWidth\":\"1920\",
               \"resolutionHeight\":\"1280\",
               \"ip\":\"63.29.38.211\"}",
               "identifier"=>"JumpstartLabs"}
  end

end
