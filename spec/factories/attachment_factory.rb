# == Schema Information
#
# Table name: attachments
#
#  id                  :integer          not null, primary key
#  attachment_for_type :string
#  attachment_for_id   :integer
#  file                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :attachment do
    attachment_for { FactoryGirl.build(:post) }
    file { '__FILE__' }
    factory :post_attachment do
      attachment_for { FactoryGirl.build(:post) }
    end
    factory :comment_attachment do
      attachment_for { FactoryGirl.build(:comment) }
    end
  end
end
