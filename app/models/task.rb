class Task < ApplicationRecord
  has_many :task_worker_histories, dependent: :destroy
  enum status: %i[queued running done]

  validates :difficulty, presence: true, numericality: { greater_than: 0 }
  validates :priority, presence: true, numericality: { greater_than: 0 }

  default_scope { order(priority: :desc, created_at: :asc) }

  def call
    sleep(difficulty)
  end

  # returning data

  def self.data
    task_stats = Task.unscoped.group(:status).count
    {
      tasks: {
        queued: task_stats['queued'] || 0,
        running: task_stats['running'] || 0,
        done: task_stats['done'] || 0,
        total: Task.count
      }
    }
  end

  def data
    {
      task: {
        id: id,
        priority: priority,
        difficulty: difficulty,
        status: status,
        created_at: created_at.to_i
      }
    }
  end

  # throw jobs to stress test that
  def self.dummy
    Worker.all.each(&:free!)
    100.times do
      Task.create(
        difficulty: 10, # (1..10).to_a.sample,
        priority: (1..3).to_a.sample
      )
    end
  end
end
