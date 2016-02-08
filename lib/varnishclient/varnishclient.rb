#!/usr/bin/env ruby

require 'varnishclient/request'
require 'varnishclient/response'

#
# VarnishClient - A class that wraps Net::HTTP objects as Varnish clients.
#

class VarnishClient

  attr_accessor :request, :response
  def initialize
    @request = VarnishClient::Request.new
    @response = VarnishClient::Response.new
  end

end
