class Worker < ApplicationRecord
  has_many :task_worker_histories
  has_many :tasks, through: :task_worker_histories
  enum status: %i[free busy]
  before_create :assign_name

  def self.give_free
    free.first
  end

  def add_task(task)
    tasks << task
  end

  def perform
    busy!
    @task = tasks.queued.first
    @task.running!
    @task.call
    @task.done!
    free!
  end

  private

  # for fun purposes
  def assign_name
    self[:name] = SecureRandom.uuid
  end
end
