#!/usr/bin/env ruby

require "shellac"

shellac = Shellac::Runner.new

varnishclient = shellac.varnishclient
varnishlog = shellac.varnishlog

shellac.run

