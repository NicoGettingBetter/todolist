class FileAttachment < ApplicationRecord
  mount_uploader :url, FileUploader
  belongs_to :comment
end
