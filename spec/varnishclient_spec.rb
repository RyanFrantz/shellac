#!/usr/bin/env ruby

require 'spec_helper'

describe VarnishClient do

  before :each do
    @varnishclient = VarnishClient.new
  end

  describe "#new" do
    it "Creates a new VarnishClient object" do
      expect(described_class).to equal(VarnishClient)
    end
    it "Should have a .request attribute that's a VarnishClient::Request object" do
      expect(@varnishclient.request).to be_an_instance_of(VarnishClient::Request)
    end
    it "Should have a .response attribute that's a VarnishClient::Response object" do
      expect(@varnishclient.response).to be_an_instance_of(VarnishClient::Response)
    end
  end

  # Request-related tests.
  describe "@varnishclient.request.host" do
    it "defaults to 'www.example.com'" do
      expect(@varnishclient.request.host).to eql('www.example.com')
    end
    it "can be updated to a custom host, like 'www.shellac.love'" do
      @varnishclient.request.host = 'www.shellac.love'
      expect(@varnishclient.request.host).to eql('www.shellac.love')
    end
  end

  describe "@varnishclient.request.path" do
    it "defaults to '/'" do
      expect(@varnishclient.request.path).to eql('/')
    end
    it "can be updated to a custom path, like '/what-else-can-shellac-do.htm'" do
      @varnishclient.request.path = '/what-else-can-shellac-do.htm'
      expect(@varnishclient.request.path).to eql('/what-else-can-shellac-do.htm')
    end
  end

  describe "@varnishclient.request.port" do
    it "defaults to port 80" do
      expect(@varnishclient.request.port).to eql(80)
    end
    it "can be updated to a custom port, like 1234" do
      @varnishclient.request.port = 1234
      expect(@varnishclient.request.port).to eql(1234)
    end
  end

end
