class Task < ApplicationRecord
  has_many :task_worker_histories, dependent: :destroy
  enum status: %i[queued running done]

  validates :difficulty, presence: true, numericality: { greater_than: 0 }
  validates :priority, presence: true, numericality: { greater_than: 0 }

  default_scope { order(priority: :desc) }

  def call
    sleep(difficulty)
  end
end
