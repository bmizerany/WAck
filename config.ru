#!/usr/bin/env rackup -p 4567
# See README for usage

require 'sinatra/base'

Lookup = {
  "gop" => "golang.org/pkg",
  "ec2" => "docs.amazonwebservices.com/AWSEC2/latest/APIReference/"
}

Search = "http://www.google.com/search?sourceid=wack&ie=UTF-8&q=%s+site:%s"

class Wack <  Sinatra::Base
  error 404 do
    redirect "/"
  end

  get "/" do
    Lookup.map {|k,v| "<strong>%s</strong> - %s<br/>" % [k, v] }
  end

  get "/ack/:slug" do |slug|
    redirect "/" if !Lookup.has_key?(slug)
    redirect Search % [
      params[:q],
      Lookup[slug]
    ].map {|x| escape(x) }
  end
end

run Wack
