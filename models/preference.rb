class Preference < ActiveRecord::Base
  belongs_to :account, validate: true
  validates :key, :value, :account, presence: true
end
