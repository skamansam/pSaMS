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

require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class AccountTest < Test::Unit::TestCase
  context "Account Model" do
    should 'construct new instance' do
      @account = Account.new
      assert_not_nil @account
    end
  end
end
