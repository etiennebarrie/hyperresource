require 'test_helper'
require 'json'

describe HyperResource do
  before do
    @server_pid = fork do
      exec(File.dirname(__FILE__)+'/live_test_server.rb 2>/dev/null')
    end

    @api = HyperResource.new(root: 'http://localhost:4567/',
                             namespace: 'WhateverAPI')

    ## Block until server is ready.
    begin
      @api.get
    rescue Faraday::Error::ConnectionFailed
      sleep 0.2
      retry
    end
  end

  after do
    Process.kill(:TERM, @server_pid)
    sleep 1
  end

  it 'works at all' do
    root = @api.get
    root.wont_be_nil
    root.name.must_equal 'whatever API'
  end
end
