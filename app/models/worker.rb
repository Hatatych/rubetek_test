class Worker < ApplicationRecord
  has_many :task_worker_histories
  has_many :tasks, through: :task_worker_histories
  enum status: %i[free busy]
  before_create :assign_name

  def self.give_free
    free.first
  end

  def add_task(task)
    @task = task
    tasks << task
  end

  def pick_task
    tasks.queued.first
  end

  def perform
    busy!
    task = @task
    task.running!
    task.call
    task.done!
    free!
  end

  # returning data

  def self.data
    worker_stats = Worker.unscoped.group(:status).count
    {
      workers: {
        free: worker_stats['free'] || 0,
        busy: worker_stats['busy'] || 0,
        total: Worker.count
      }
    }
  end

  def data
    {
      worker: {
        id: id,
        name: name,
        status: status,
        completed_tasks: tasks.done.count
      }
    }
  end

  private

  # for fun purposes
  def assign_name
    self[:name] = SecureRandom.uuid
  end
end
