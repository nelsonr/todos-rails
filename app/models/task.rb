class Task < ActiveRecord::Base
  attr_accessible :content, :todo_id, :finished

  belongs_to :todo
end
