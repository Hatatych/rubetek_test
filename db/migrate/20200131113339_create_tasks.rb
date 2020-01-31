class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :priority, null: false
      t.integer :difficulty, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
