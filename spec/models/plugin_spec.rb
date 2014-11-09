# == Schema Information
#
# Table name: plugins
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  priority    :integer
#  plugin_type :string(255)
#  file_name   :string(255)
#  line_number :integer
#  class_name  :string(255)
#  method_name :string(255)
#  hook_name   :string(255)
#  num_args    :integer
#  options     :text
#  active      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  context     :string(255)      default("*")
#

require 'spec_helper'

describe Plugin do
end
