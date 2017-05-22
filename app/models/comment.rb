class Comment < ApplicationRecord
  belongs_to :task
  has_many :file_attachments

  validates_presence_of :text, :task_id
end
