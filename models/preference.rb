class Preference < ActiveRecord::Base
  belongs_to :user
  validates :key, :value, :user, presence: true
end
