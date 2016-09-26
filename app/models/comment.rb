class Comment < ApplicationRecord
  belongs_to :task

  validates_presence_of :text, :task_id
end
