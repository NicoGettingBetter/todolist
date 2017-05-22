class FileAttachment < ApplicationRecord
  mount_uploader :url, FileUploader
  belongs_to :comment

  validates_presence_of :url, :comment_id
end
