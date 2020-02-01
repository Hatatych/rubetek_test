module HintManager
  extend ActiveSupport::Concern

  def add_hint
    @data[:hint] = 'Check queue balancer. Perhaps, it failed' if balancer_failed?
    @data[:hint] = 'Add some workers, there are enqueued tasks and no free workers' if few_workers?
  end

  private

  def balancer_failed?
    tasks = task_stats
    return true if tasks['running'].nil? && tasks['queued']&.positive? && Worker.free.count.positive?

    false
  end

  def few_workers?
    workers = worker_stats
    tasks = task_stats
    return true if workers['free'].nil? && workers['busy'] == tasks['running'] && tasks['queued']&.positive?

    false
  end

  def task_stats
    Task.unscoped.group(:status).count
  end

  def worker_stats
    Worker.unscoped.group(:status).count
  end
end
