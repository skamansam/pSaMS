require 'spec_helper'

RSpec.describe "PluginManager Controller", :type => :controller do
  it "redirects without login" do
    get "/admin/plugins"
    expect(last_response.location).to eql 'http://example.org/admin/sessions/new'
  end
end
