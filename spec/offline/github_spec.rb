require 'spec_helper'

describe Offline::Github do
  it "should assign the github user to @username" do
    Offline::Github.new('test').username.should == 'test'
  end

  context "#repositories" do
    before :each do
      response = mock("response", :parsed_response => {"repositories" => []})
      Offline::Github.should_receive(:get).with("/repos/show/test").and_return(response)
    end

    it "should return a list of repositories" do
      Offline::Github.new('test').repositories.should == []
    end
  end
end