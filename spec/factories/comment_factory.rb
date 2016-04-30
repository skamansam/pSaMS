# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text
#  title            :string
#  user_id          :integer
#  email            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_for_id   :integer
#  comment_for_type :string
#

FactoryGirl.define do
  factory :comment do
    title { Forgery('lorem_ipsum').words }
    body { Forgery('lorem_ipsum').paragraph }
    user { FactoryGirl.build(:account) }
    comment_for { FactoryGirl.build(:post) }

    factory :post_comment do
      comment_for { FactoryGirl.build(:post) }
    end
  end
end
