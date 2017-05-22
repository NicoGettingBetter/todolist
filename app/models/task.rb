class Task < ApplicationRecord
  belongs_to :project
  has_many :comments

  validates_presence_of :title, :project_id
end
