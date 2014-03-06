# This file should contain all record creation needed to seed database with its default values.
# data cann be loaded with rake db:seed (or created alongside db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def todo_name
  lists_names = ['Week Tasks', 'Month Tasks',
                 'Tomorrow Tasks', 'Yesterday Tasks',
                 'Mars Log', 'Jupiter Log',
                 'Sauron Demands', 'Batman Batodos',
                 'Superman Wishes', 'Wolverine Groceries List']

  lists_names.shuffle.first
end

def create_sentence
  actions  = ['Take', 'Clean', 'Sort', 'Move', 'Watch', 'Talk to', 'Go to', 'Listen to']
  articles = ['the', 'your', 'my', 'their']
  subjects = ['dog', 'sister', 'mom', 'house', 'door', 'table', 'car', 'bike',
              'room', 'bag', 'television', 'clothes', 'paintings', 'laundry']

  actions.shuffle.first + ' ' + articles.shuffle.first + ' ' + subjects.shuffle.first
end

user = User.create!(name:                  'John Doe',
                    email:                 'john@example.com',
                    password:              'password',
                    password_confirmation: 'password')

todo = user.todos.create!(title: 'Todo A')

todo.tasks.create!([{ content: 'Task 1' },
                    { content: 'Task 2' },
                    { content: 'Task 3' }])

20.times do |n|
  name     = Faker::Name.name
  email    = "john-#{n+1}@example.com"
  password = 'password'

  user = User.create!(name:                  name,
                      email:                 email,
                      password:              password,
                      password_confirmation: password)

  todo = user.todos.create!(title: todo_name)

  the_tasks = []

  10.times do
    the_tasks.push({ content: create_sentence })
  end

  todo.tasks.create!(the_tasks)
end

