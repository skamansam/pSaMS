# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  name             :string
#  surname          :string
#  email            :string
#  crypted_password :string
#  role             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :account do
    name { Forgery(:name).first_name }
    surname { Forgery('name').last_name }
    email { Forgery(:internet).email_address }
    password 'test123'
    password_confirmation 'test123'
    role 'user'

    factory :admin do
      role 'admin'
    end
  end
end
