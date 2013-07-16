#!/usr/bin/env ruby
require 'sinatra'
require 'json'

class HyperResourceTestServer < Sinatra::Base

#  set :run, true

  get '/' do
    errors = verify_headers
    if errors
      JSON.dump(errors)
    else
      headers['Content-type'] = 'application/vnd.example.v1+hal+json;type=Root'
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
    errors = verify_headers
    if errors
      JSON.dump(errors)
    else
      headers['Content-type'] = 'application/vnd.example.v1+hal+json;type=WidgetSet'
      JSON.dump(
        { name: "My Widgets",
          _links: {
            self: {href:"/widgets"},
            root: {href:"/"}
          },
          _embedded: {
            widgets: [
              { name: "Widget 1",
                _links: {
                  self: {href: "/widgets/1"},
                  widgets: {href: "/widgets"}
                }
              }
            ]
          }
        }
      )
    end
  end

  post '/widgets' do

  end

  put '/widgets/:widget_id' do

  end

  delete '/widgets/:widget_id' do

  end

  def verify_headers
  end

end
