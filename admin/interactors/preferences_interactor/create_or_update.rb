class PreferencesInteractor::CreateOrUpdate
  include Interactor
  attr_reader :account,:key,:value,:context, :preference, :errors

  def initialize(user,key,value,context)
    @account = user
    @key     = key
    @value   = value
    @context = context || '*'
  end
  def perform
    if preference = Preference.where(key: key, account_id: account.id, context: context).first_or_create
      preference.update_attributes(value: value)
    else
      preference = user.create_preference(key: key, value: value, context: context)
    end
    if errors = preference.errors.full_messages.join('. ')
      false
    else
      true
    end
  end
end
