def get_pref(user = current_account, context, key)
  Preference.where(user_id: user.try(:id), context: context, key: key).first
end
def set_pref(user = current_account, context, key, value)
  Preference.where(user_id: user.try(:id), context: context, key: key).first_or_create.update_attributes(value: value)
end
