class Attachment < ActiveRecord::Base
  belongs_to :attachment_for, polymorphic: true
  mount_uploader :file, AttachmentUploader
end
