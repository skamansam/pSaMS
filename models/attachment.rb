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
# Represents an attachment. It can be anything
class Attachment < ActiveRecord::Base
  belongs_to :attachment_for, polymorphic: true
  mount_uploader :file, AttachmentUploader
end
