# Helper methods defined here can be accessed in any controller or view in the application

PSaMs::App.helpers do
  # def simple_helper_method
  #  ...
  # end
  def account_link(account)
    return "Unknown" unless account
    link_to account.name+' '+account.surname, 'mailto:'+account.email
  end
end
