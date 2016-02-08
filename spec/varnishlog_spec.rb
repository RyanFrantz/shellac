#!/usr/bin/env ruby

require 'spec_helper'

describe VarnishLog do

  before :each do
    @varnishlog = VarnishLog.new
    varnishlog_output =  "*   << Request  >> 606123948 \n-   Begin          req 606123947 rxreq\n-   Timestamp      Start: 1454350985.766917 0.000000 0.000000\n-   Timestamp      Req: 1454350985.766917 0.000000 0.000000\n-   ReqStart       127.0.0.1 35937\n-   ReqMethod      GET\n-   ReqURL         /api/v7/find_user\n-   ReqProtocol    HTTP/1.1\n-   ReqHeader      Accept: */*\n-   ReqHeader      User-Agent: shellac\n-   ReqHeader      Host: www.example.com\n-   ReqHeader      Connection: close\n-   ReqHeader      X-Forwarded-For: 127.0.0.1\n-   VCL_call       RECV\n-   ReqUnset       X-Forwarded-For: 127.0.0.1\n-   ReqHeader      X-Forwarded-For: 127.0.0.1, 127.0.0.1\n-   VCL_return     hash\n-   VCL_call       HASH\n-   VCL_return     lookup\n-   Debug          \"XXXX MISS\"\n-   VCL_call       MISS\n-   VCL_return     fetch\n-   Link           bereq 606123949 fetch\n-   Timestamp      Fetch: 1454350985.832164 0.065247 0.065247\n-   RespProtocol   HTTP/1.1\n-   RespStatus     200\n-   RespReason     OK\n-   RespHeader     Date: Mon, 01 Feb 2016 18:23:05 GMT\n-   RespHeader     Server: Apache\n-   RespHeader     Cache-Control: max-age=60, public\n-   RespHeader     Vary: Accept-Encoding\n-   RespHeader     Content-Encoding: gzip\n-   RespHeader     Content-Length: 726\n-   RespHeader     X-Cnection: close\n-   RespHeader     Content-Type: application/json\n-   RespHeader     X-Varnish: 606123948\n-   RespHeader     Age: 0\n-   RespHeader     Via: 1.1 varnish-v4\n-   VCL_call       DELIVER\n-   RespHeader     X-Cache-Status: MISS\n-   VCL_return     deliver\n-   Timestamp      Process: 1454350985.832222 0.065305 0.000057\n-   RespUnset      Content-Encoding: gzip\n-   RespUnset      Content-Length: 726\n-   RespHeader     Transfer-Encoding: chunked\n-   Debug          \"RES_MODE 48\"\n-   RespHeader     Connection: close\n-   RespHeader     Accept-Ranges: bytes\n-   Gzip           U D - 726 5243 80 80 5739\n-   Timestamp      Resp: 1454350985.832356 0.065439 0.000134\n-   Debug          \"XXX REF 2\"\n-   ReqAcct        148 0 148 522 5258 5780\n-   End            \n\n"
    @varnishlog.parse(varnishlog_output)
  end

  describe "#new" do
    it "creates a new VarnishLog object" do
      expect(described_class).to equal(VarnishLog)
    end
    it "should have a .request attribute that's a VarnishLog::Request object" do
      expect(@varnishlog.request).to be_an_instance_of(VarnishLog::Request)
    end
    it "should have a .response attribute that's a VarnishLog::Response object" do
      expect(@varnishlog.response).to be_an_instance_of(VarnishLog::Response)
    end
  end

  # Test an explicitly defined method.
  describe "@varnishlog.request.url" do
    it "returns the URL path requested from Varnish" do
      expect(@varnishlog.request.url).to eql("/api/v7/find_user")
    end
  end

  # Test an implicitly defined method.
  describe "@varnishlog.response.date" do
    it "returns the Date response header sent by Varnish" do
      expect(@varnishlog.response.date).to eql("Mon, 01 Feb 2016 18:23:05 GMT")
    end
  end

end
