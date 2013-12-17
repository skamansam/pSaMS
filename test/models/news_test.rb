require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class NewsTest < Test::Unit::TestCase
  context "News Model" do
    should 'construct new instance' do
      @news = News.new
      assert_not_nil @news
    end
  end
end
