#!/usr/bin/env ruby

require "net/http"
require "uri"

#
# VarnishClient::Request - A class that wraps Net::HTTP::Request objects.
#

class VarnishClient
  class Request

    attr_accessor :uri, :request
    # Initialize a VarnishClient::Request object.
    def initialize
      # Set some default values.
      # We're running `varnishlog` on localhost.
      default_http_hostname = 'http://localhost'
      default_http_port = '80'
      default_request_uri = '/'
  
      @uri = URI.parse("#{default_http_hostname}:#{default_http_port}#{default_request_uri}")
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @request_headers = {
        'Host' => 'www.example.com',
        'User-Agent' => 'shellac'
      }
      @request = Net::HTTP::Get.new(@uri.request_uri, @request_headers)
    end
  
    # Get the request headers.
    def headers
      @request_headers
    end
  
    # Get the Host header for the request.
    def host
      @request['Host']
    end
  
    # Set the Host header for the request.
    def host=(host_header)
      @request_headers['Host'] = host_header
      @request = Net::HTTP::Get.new(@uri.request_uri, @request_headers)
    end
  
    # Get the path of the request.
    def path
      @uri.request_uri
    end
  
    # Set the path of the request.
    def path=(path)
      @uri.path = path
      @request = Net::HTTP::Get.new(@uri.request_uri, @request_headers)
    end
  
    # Get the port of the request.
    def port
      @uri.port
    end
  
    # Set the port of the request.
    def port=(port)
      @uri.port = port
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @request = Net::HTTP::Get.new(@uri.request_uri, @request_headers)
    end
  
    # Get the User-Agent header.
    def user_agent
      @request['User-Agent']
    end
  
    # Set the User-Agent header.
    def user_agent=(user_agent)
      @request_headers['User-Agent'] = user_agent
      @request = Net::HTTP::Get.new(@uri.request_uri, @request_headers)
    end
  
    # Make the HTTP request.
    def make_request
      response = @http.request(@request)
    end

  end
end
