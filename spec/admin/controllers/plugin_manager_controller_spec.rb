require 'spec_helper'

RSpec.describe "PluginManagerController", type: :controller do
  before do
    get "/"
  end

  it "returns hello world" do
    last_response.body.should == "Hello World"
  end
end
