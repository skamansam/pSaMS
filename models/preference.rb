class Preference < ActiveRecord::Base
  belongs_to :user

  def self.get(context,key)
    where id: current_user.try(:id), context: context, key: key
  end
end
