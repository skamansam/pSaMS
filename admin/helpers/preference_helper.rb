def get_pref(context, key, user = current_account)
  Preference.where(account_id: user.try(:id), context: context, key: key).first.value
end
def set_pref(user = current_account, context, key, value)
  Preference.where(account_id: user.try(:id), context: context, key: key).first_or_create.update_attributes(value: value)
end
