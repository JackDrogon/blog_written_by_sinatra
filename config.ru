$LOAD_PATH.unshift File.dirname(__FILE__)
require './app/blog'

run Sinatra::Application
