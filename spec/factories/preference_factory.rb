# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  account_id :integer
#  context    :string           default("*")
#  key        :string
#  value      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :preference do
    name { Forgery('lorem_ipsum').word }
    description { Forgery('lorem_ipsum').words }
  end
end
