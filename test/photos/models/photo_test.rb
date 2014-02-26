require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class PhotoTest < Test::Unit::TestCase
  context "Photo Model" do
    should 'construct new instance' do
      @photo = Photo.new
      assert_not_nil @photo
    end
  end
end
