#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'sinatra'
require "sinatra/reloader" if development?
require 'rdiscount'
require 'tilt/redcarpet'
require 'tilt/erubis'

require_relative 'blog_config.rb'


get '/' do
  "Hello, Blog!"
end

get '/env' do
  env.inspect
end

get '/articles' do
  # FIXME: Rewrite
  article = <<-ARTICLE
  <h1><center>List Articles</center></h1> </br>
  ARTICLE
  Dir.entries(Articles).select {|p| p[0] != "." }
     .sort {|a, b| b <=> a}
     .each {|a| article << "<a href=\"/articles/#{a}\"> #{a} </a> <br />\n"}

  article
end

get '/articles/:name' do
  article_name = "#{Articles}/#{params[:name]}"
  if File.readable? article_name
    article ||= markdown(File.read(article_name))
    # FIXME: Here Document Problem
    # You get artitle #{params['name']}!<br \>
    @article = <<-ARTICLE
    Article is:
    #{article}
    ARTICLE
    erb :blog
  else
    "NOT_FOUND #{params['name']}"
  end
end

__END__

@@blog

<h1> Blog </h1>
<%= @article %>
