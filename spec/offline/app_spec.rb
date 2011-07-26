require 'spec_helper'

describe Offline::App do
  context "Thor" do
    it "should respond to start" do
      Offline::App.should respond_to(:start)
    end
  end

  context "#mirror" do
    it "should respond to start" do
      Offline::App.should respond_to(:start)
    end
  end
end