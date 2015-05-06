# == Schema Information
#
# Table name: attachments
#
#  id                  :integer          not null, primary key
#  attachment_for_type :string
#  attachment_for_id   :integer
#  file                :string
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

RSpec.describe Attachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
