#!/usr/bin/env ruby

require "net/http"

#
# VarnishClient::Response - A class that wraps Net::HTTP::Response objects.
#

# To be honest, we aren't doing anything here. This class exists in case
# some sort of extra work needs to be done beyond what a Net::HTTPResponse
# object provides.
# (We're assigning the result of a Net::HTTPRequest to this object.)

class VarnishClient
  class Response

    # Initialize a VarnishClient::Response object.
    def initialize
      @response = Net::HTTPResponse
    end
  
  end
end
