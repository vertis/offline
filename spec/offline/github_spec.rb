require 'spec_helper'

describe Offline::Github do
  it "should assign the github user to @username" do
    Offline::Github.new('test').username.should == 'test'
  end

  context "authenticated user" do
    it "should fail if I give the wrong password" do
      expect { Offline::Github.new('vertis', 'password') }.to raise_error
    end
  end
  
  describe "#repositories" do
    it "should return a list of repositories" do
      user_response = mock("response", :parsed_response => {})
      response = mock("response", :parsed_response => {"repositories" => []})
      Offline::Github.should_receive(:get).with("/repos/show/test").and_return(response)
      Offline::Github.new('test').repositories.should == []
    end
    
    it "should return only private repositories if requested" do
      user_response = mock("response", :parsed_response => {})
      response = mock("response", :parsed_response => {"repositories" => [{"name" => 'public_repo', "private"=>false}, {"name" => 'private_repo', "private"=>true}]})
      Offline::Github.should_receive(:get).with("/user/show").and_return(user_response)
      Offline::Github.should_receive(:get).with("/repos/show/test").and_return(response)
      repos = Offline::Github.new('test', 'password').repositories('test', :"private-only")
      repos.count.should == 1
      repos.should == [{"name" => 'private_repo', "private"=>true}]
    end
  end
end