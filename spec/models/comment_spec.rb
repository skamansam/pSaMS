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

