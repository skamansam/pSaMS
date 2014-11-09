# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  surname          :string(255)
#  email            :string(255)
#  crypted_password :string(255)
#  role             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class AccountTest < Test::Unit::TestCase
  context "Account Model" do
    should 'construct new instance' do
      @account = Account.new
      assert_not_nil @account
    end
  end
end
