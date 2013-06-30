#!/usr/bin/env ruby
require 'sinatra'
require 'json'

get '/' do
  errors = verify_headers
  if errors
    JSON.dump(errors)
  else
    headers['Content-type'] = 'application/vnd.example.v1+hal+json'
    JSON.dump(
      { name: "whatever API",
        _links: {
          self: {href:"/"},
          widgets: {href:"/widgets"}
        }
      }
    )
  end
end

get '/widgets' do

end

post '/widgets' do

end

put '/widgets/:widget_id' do

end

delete '/widgets/:widget_id' do

end


def verify_headers
end
