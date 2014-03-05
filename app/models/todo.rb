class Todo < ActiveRecord::Base
  attr_accessible :title, :private, :tasks_attributes

  belongs_to :user
  has_many :tasks
  accepts_nested_attributes_for :tasks
end
