class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :content
      t.integer :todo_id
      t.boolean :finished

      t.timestamps
    end
  end
end