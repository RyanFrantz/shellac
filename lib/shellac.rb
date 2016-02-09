#!/usr/bin/env ruby

require 'varnishclient/varnishclient'
require 'varnishlog/varnishlog'
require 'headers'
require 'ripl'

# Define some colors we'll use in some output.
RED = "\e[1;31m"
GREEN = "\e[1;32m"
YELLOW = "\e[1;33m"
NORMAL = "\e[0;0m"

module Shellac

  class Runner
    attr_accessor :varnishclient, :varnishlog
  
    def initialize
      @varnishclient = VarnishClient.new
      @varnishlog = VarnishLog.new
    end
  
    def run
      # Inform the user of the default request.
      puts "\nDefault request: #{RED}#{@varnishclient.request.uri.to_s}#{NORMAL}"
      puts "HTTP Port (varnishclient.request.port): #{RED}#{@varnishclient.request.port}#{NORMAL}"
      puts "HTTP Request Path (varnishclient.request.path): #{RED}#{@varnishclient.request.path}#{NORMAL}"
      puts "HTTP Host Header (varnishclient.request.host): #{RED}#{@varnishclient.request.host}#{NORMAL}"
      puts "\n#{RED}You may want to to modify this before calling #{NORMAL}@varnishclient.make_request#{RED}!#{NORMAL}"
  
      # Start our REPL.
      Ripl.config[:prompt] = "\nshellac> "
      # Bind Ripl to the context of this instance so that all of the objects
      # accessible to it (and their methods) are accessible to the user in the REPL.
      # 'binding' is a private method that returns a Binding object; we can only
      # access it here via the #instance_eval method.
      Ripl.start :binding => self.instance_eval{binding}
    end
  
    # 1. Starts a thread to spawn a `varnishlog` subprocess that will catch our HTTP request.
    # 2. Executes the HTTP request to Varnish.
    # 3. Reaps the `varnishlog` thread so that its output can be parsed into the @varnishlog.response object.
    # Returns nothing.
    def make_request
      @varnishlog.start_varnishlog_thread(@varnishclient.request.user_agent)
      # Sleeping is a hack to give the varnishlog thread time to get in place.
      # Without it, there's a roughly 50/50 chance (sometimes worse) that the thread
      # will block on I/O as if it missed the HTTP request (because it did).
      sleep(0.5)
  
      @varnishclient.response = @varnishclient.request.make_request

      case @varnishclient.response.code
      when /2\d{2}/
        color = GREEN
      when /3\d{2}/
        color = YELLOW
      when /4\d{2}/
        color = RED
      else
        color = NORMAL
      end
      puts "\n#{@varnishclient.request.uri.to_s}: #{color}#{@varnishclient.response.code} #{@varnishclient.response.message}#{NORMAL}\n\n"

      @varnishlog.reap_thread
    end
  end

end
