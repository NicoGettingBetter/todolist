class Project < ApplicationRecord
  #belongs_to :users
  has_many :tasks

  def as_json(options = {})
    super(options.merge(include: :tasks))
  end
end
