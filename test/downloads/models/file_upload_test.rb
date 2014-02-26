require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class FileUploadTest < Test::Unit::TestCase
  context "FileUpload Model" do
    should 'construct new instance' do
      @file_upload = FileUpload.new
      assert_not_nil @file_upload
    end
  end
end
