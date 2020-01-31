class CreateTaskWorkerHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :task_worker_histories do |t|
      t.references :worker, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
