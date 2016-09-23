class Project < ApplicationRecord
  #belongs_to :user
  has_many :tasks

  def as_json(options = {})
    super(options.merge(include: {
      tasks: { include: :comments }
      }))
  end
end
