FactoryGirl.define do
  factory :account do
    name { Forgery(:name).full_name }
    surname "User"
    email "test123@123.com" #{ Forgery(:internet).email_address }
    password "test123"
    password_confirmation "test123"

    factory :admin do
      role "admin"
    end

  end
end
