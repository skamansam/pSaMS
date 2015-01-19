class Preference < ActiveRecord::Base
  belongs_to :user

  def self.get(context,key)
    where(user_id: current_user.try(:id), context: context, key: key).first
  end
  def self.set(context,key,value)
    where(user_id: current_user.try(:id), context: context, key: key).first_or_create
      .update_attributes(value: value)
  end
end
