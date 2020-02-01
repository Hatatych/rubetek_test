module Tasker
  class Balancer
    def self.start
      loop do
        Task.queued.find_each do |task|
          sleep 0.2
          worker = Worker.give_free
          next unless worker

          worker.add_task(task)
          Thread.new { worker.perform }
        end
      end
    end
  end
end
