# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_order  :integer
#  parent_id   :integer
#  link        :string
#

FactoryGirl.define do
  factory :category do
    name { Forgery('lorem_ipsum').word }
    description { Forgery('lorem_ipsum').words }
  end
end
