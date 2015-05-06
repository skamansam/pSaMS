# == Schema Information
#
# Table name: plugins
#
#  id          :integer          not null, primary key
#  name        :string
#  priority    :integer
#  plugin_type :string
#  file_name   :string
#  line_number :integer
#  class_name  :string
#  method_name :string
#  hook_name   :string
#  num_args    :integer
#  options     :text
#  active      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  context     :string           default("*")
#

require 'spec_helper'

describe Plugin do
end
