class PreferencesInteractor::CreateOrUpdate 
  include Interactor
  attr_accessible :user,:key,:value,:context, :preference

  def initialize(user,key,value,context)
    @user    = user
    @key     = key
    @value   = value
    @context = context || '*'
  end
  def perform
    preference = user.create_preferences(key: key, value: value, context: context)
    preference.save
    errors = preference.errors.messages.join('. ')
  end
end