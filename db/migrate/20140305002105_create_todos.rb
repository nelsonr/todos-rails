class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.integer :user_id
      t.boolean :private

      t.timestamps
    end
  end
end
