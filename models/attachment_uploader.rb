class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    'public/uploads'
  end
end
