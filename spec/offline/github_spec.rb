require 'spec_helper'

describe Offline::Github do
  it "should assign the github user to @username" do
    Offline::Github.new('test').username.should == 'test'
  end

  describe "#repositories" do
    it "should return a list of repositories" do
      response = mock("response", :parsed_response => {"repositories" => []})
      Offline::Github.should_receive(:get).with("/repos/show/test").and_return(response)
      Offline::Github.new('test').repositories.should == []
    end
    
    it "should return only private repositories if requested" do
      response = mock("response", :parsed_response => {"repositories" => [{"name" => 'public_repo', "private"=>false}, {"name" => 'private_repo', "private"=>true}]})
      Offline::Github.should_receive(:get).with("/repos/show/test").and_return(response)
      repos = Offline::Github.new('test').repositories(:"private-only")
      repos.count.should == 1
      repos.should == [{"name" => 'private_repo', "private"=>true}]
    end
  end
end