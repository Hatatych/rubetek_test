namespace :tasker do
  desc "TODO"
  task start_balancer: :environment do
    Tasker::Balancer.start
  end

end
