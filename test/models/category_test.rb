# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  item_order  :integer
#  parent_id   :integer
#  link        :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CategoryTest < Test::Unit::TestCase
  context "Category Model" do
    should 'construct new instance' do
      @category = Category.new
      assert_not_nil @category
    end
  end
end
