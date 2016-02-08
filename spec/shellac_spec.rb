#!/usr/bin/env ruby

require 'spec_helper'

describe Shellac::Runner do

  before :each do
    @shellac = Shellac::Runner.new
  end

  describe "#new" do
    it "Creates a new Shellac::Runner object" do
      expect(described_class).to equal(Shellac::Runner)
    end
    it "Should have a .varnishlog attribute that's a VarnishLog object" do
      expect(@shellac.varnishlog).to be_an_instance_of(VarnishLog)
    end
    it "Should have a .varnishclient attribute that's a VarnishClient object" do
      expect(@shellac.varnishclient).to be_an_instance_of(VarnishClient)
    end
  end

end
