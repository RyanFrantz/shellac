#!/usr/bin/env ruby

require "shellac"

shellac = Shellac.new

varnishclient = shellac.varnishclient
varnishlog = shellac.varnishlog

shellac.run

