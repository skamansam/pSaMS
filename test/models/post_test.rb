# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#  account_id  :integer
#  category_id :integer
#  path        :string
#  is_news     :boolean          default("f")
#  published   :boolean          default("f")
#

require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PostTest < Test::Unit::TestCase
  context "Post Model" do
    should 'construct new instance' do
      @post = Post.new
      assert_not_nil @post
    end
  end
end
