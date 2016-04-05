FactoryGirl.define do
  factory :user do
    name { Forgery(:name).full_name }
    surname 'User'
    email { Forgery(:internet).email_address }
    password 'test123'
    password_confirmation 'test123'
  end
end
