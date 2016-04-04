require 'spec_helper'

RSpec.describe "PSaMs::Admin::PluginManagerHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend PSaMs::Admin::PluginManagerHelper }
  subject { helpers }

  it "should return nil" do
    expect(subject.foo).to be_nil
  end
end
