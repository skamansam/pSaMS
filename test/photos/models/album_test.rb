require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class AlbumTest < Test::Unit::TestCase
  context "Album Model" do
    should 'construct new instance' do
      @album = Album.new
      assert_not_nil @album
    end
  end
end
