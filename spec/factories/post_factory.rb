# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :integer
#  category_id :integer
#  path        :string
#  is_news     :boolean          default(FALSE)
#  published   :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :post do
    title "I am a Post"
    body "The body text"
    account
    category
    published true

    factory :unpublished_post do
      published false
    end
  end
end
