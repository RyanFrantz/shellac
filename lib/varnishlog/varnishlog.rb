#!/usr/bin/env ruby

require 'varnishlog/request'
require 'varnishlog/response'

#
# VarnishLog - A class to define objects that contain a transaction captured
#              by `varnishlog`.
#

class VarnishLog
  attr_reader :request, :response

  # Create a new VarnishLog object.
  #
  # Returns a VarnishLog object with two attributes that are request and response objects.
  def initialize
    @request = VarnishLog::Request.new
    @response = VarnishLog::Response.new
  end

  def start_varnishlog_thread(user_agent="shellac")
    @varnishlog_thread = Thread.new {
      output = `varnishlog -q 'ReqHeader:User-Agent eq "#{user_agent}"' -k 1`
    }
    @varnishlog_thread
  end

  def reap_thread
    transaction = @varnishlog_thread.value
    parse(transaction)
  end

  # Parses the output of a transaction captured by `varnishlog` into attributes
  # that are assigned to a VarnishLog object.
  def parse(transaction)
    items = transaction.split("\n")

    # Requests
    ## Request headers.
    request_headers = items.grep(/ReqHeader/)
    request_headers.each do |header|
      if match = /-\s+ReqHeader\s+(?<header_name>.*): (?<header_value>.*)/.match(header)
        @request.add_header(match['header_name'], match['header_value'])
      end
    end

    ## Match ReqMethod.
    if method_match = /-\s+ReqMethod\s+(?<method>.*)/.match(items.grep(/ReqMethod/)[0])
      @request.method = method_match['method']
    end
    ## Match ReqURL.
    if url_match = /-\s+ReqURL\s+(?<url>\/.*)/.match(items.grep(/ReqURL/)[0])
      @request.url = url_match['url']
    end
    ## Match ReqProtocol.
    if protocol_match = /-\s+ReqProtocol\s+(?<protocol>.*)/.match(items.grep(/ReqProtocol/)[0])
      @request.protocol = protocol_match['protocol']
    end

    # Response.
    ## Response headers.
    response_headers = items.grep(/RespHeader/)
    response_headers.each do |header|
      if match = /-\s+RespHeader\s+(?<header_name>.*): (?<header_value>.*)/.match(header)
        @response.add_header(match['header_name'], match['header_value'])
      end
    end

  end

end
