# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(name: 'John Doe 1',
                    email: 'john1@example.com',
                    password: 'password',
                    password_confirmation: 'password')

todo = user.todos.create!(title: 'Todo A')

todo.tasks.create!([{content: 'Task 1'},
                    {content: 'Task 2'},
                    {content: 'Task 3'}])