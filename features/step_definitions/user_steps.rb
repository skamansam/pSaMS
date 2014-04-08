Given /^I am an? "(.*)" user$/ do |user_type|
  @user = create(:admin)
  #@user = FactoryGirl.create(user_type.downcase.to_sym)
  #visit '/admin'
end

Given /^I have the credentials "(\S+)\/(\S+)"$/ do |email,pwd|
  @user.email = email
  @user.password = pwd
  @user.password_confirmation = pwd 
end

When /^I sign|log ?in to the admin console$/ do
  visit "/admin"
  fill_in :email, @user.email
  fill_in :password, @user.password
  #visit '/admin'
end

