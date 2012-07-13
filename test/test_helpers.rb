ENV['RACK_ENV'] ||= 'test'
require 'test/unit'
require 'minitest/spec'
require 'rack'
require 'rack/test'
require 'json'
require 'factory_girl'
require 'database_cleaner'
require 'wd_sinatra/test_helpers'
require './config/application'

ENV['DONT_PRINT_ROUTES'] = 'true'
root = File.expand_path('..', File.dirname(__FILE__))
WDSinatra::AppLoader.server(root)
WeaselDiesel.send(:include, JSONResponseVerification)

DatabaseCleaner.strategy = :transaction
FactoryGirl.find_definitions

if RUBY_VERSION =~ /1.8/
  require 'minitest/autorun'
end

require 'wd_sinatra/test_unit_helpers'
include TestUnitHelpers

TestApi.auth_request_x_header = WDSinatraHooks::INTERNAL_X_HEADER[/HTTP_(.*)/, 1] # strip the header marker added by Rack
TestApi.mobile_request_x_header = WDSinatraHooks::MOBILE_X_HEADER[/HTTP_(.*)/, 1]   # strip the header marker added by Rack

module TestApi

  # Edit this method to reflect your own Auth strategy
  def self.valid_internal_api_headers(headers)
    custom_headers = {TestApi.auth_request_x_header => WDSinatraHooks::ALLOWED_API_KEYS[0]}
    custom_headers.merge!(headers) if headers
    custom_headers
  end

  # Edit this method to reflect your own Auth strategy
  def self.mobile_headers(headers)
    custom_headers = {TestApi.mobile_request_x_header => 'fake_example'}
    custom_headers.merge!(headers) if headers
    custom_headers
  end

end
