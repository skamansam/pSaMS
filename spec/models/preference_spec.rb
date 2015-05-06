# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  account_id :integer
#  context    :string           default("*")
#  key        :string
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Preference do
end
