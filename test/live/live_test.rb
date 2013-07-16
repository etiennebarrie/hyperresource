require 'test_helper'
require 'rack'
require 'json'
require File.expand_path('../live_test_server.rb', __FILE__)

describe HyperResource do
  before do
    @port = 20000 + rand(10000)
    @server_pid = Process.fork do
      $stdout.reopen('/dev/null', 'w+')
      $stderr.reopen('/dev/null', 'w+')
      Rack::Handler::WEBrick.run(HyperResourceTestServer.new, Port: @port)
    end

    @api = HyperResource.new(root: "http://localhost:#{@port}/",
                             namespace: 'WhateverAPI')

    ## Block until server is ready.
    @api.get rescue sleep(0.2) and retry
  end

  after do
    Process.kill('TERM', @server_pid)
  end

  describe 'live tests' do
    it 'works at all' do
      root = @api.get
      root.wont_be_nil
      root.name.must_equal 'whatever API'
      root.must_be_kind_of HyperResource
      root.must_be_instance_of WhateverAPI::Root
    end

    it 'follows links' do
      root = @api.get
      #root.must_respond_to :widgets
      root.links.must_respond_to :widgets
      widgets = root.widgets.get
      widgets.must_be_kind_of HyperResource
    end
  end

end


