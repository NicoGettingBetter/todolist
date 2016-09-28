class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  def as_json(options = {})
    super(options.merge(include: [
      :user,
      tasks: { include: [
        comments: { include: :file_attachments }
      ]}
    ]))
  end

  validates_presence_of :title, :user_id
end
