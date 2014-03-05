class Todo < ActiveRecord::Base
  attr_accessible :title, :private

  belongs_to :user
  has_many :tasks
end
