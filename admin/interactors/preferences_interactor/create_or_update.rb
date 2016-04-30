class PreferencesInteractor::CreateOrUpdate
  include Interactor
  attr_reader :account, :key, :value, :context, :preference, :errors

  def initialize(options)
    @account = options[:account]
    @key     = options[:key]
    @value   = options[:value]
    @context = options[:context] || '*'
  end

  def perform
    preference = account.preferences.where(key: key, context: context).first_or_create
    preference.update_attributes(value: value)

    (@errors = preference.errors.full_messages.join('. ')).blank?
  end
end
