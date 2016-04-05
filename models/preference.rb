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

class Preference < ActiveRecord::Base
  belongs_to :account, validate: true
  validates :key, :value, :account, presence: true
end
