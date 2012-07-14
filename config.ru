require 'rubygems'
require 'wd_sinatra/app_loader'
require './config/application'

root = File.expand_path(File.dirname(__FILE__))

WDSinatra::AppLoader.server(root)
run Sinatra::Application