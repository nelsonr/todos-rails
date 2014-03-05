class Task < ActiveRecord::Base
  attr_accessible :content, :todo_id, :finished
  validates :content, presence: true

  belongs_to :todo
end
