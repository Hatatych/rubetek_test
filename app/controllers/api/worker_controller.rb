module Api
  class WorkerController < BaseController
    def status
      default_data
      worker = Worker.find(params[:worker_id])
      @data.merge!(worker.data)
      render json: @data
    rescue ActiveRecord::RecordNotFound => e
      data = not_found_data message: e.message, backtrace: e.backtrace[1..10]
      render json: @data.merge!(data)
    end

    def create
      @worker = Worker.create!
      default_data.merge!(@worker.data) && respond
    rescue ActiveRecord::RecordInvalid
      data = error_data @worker
      @data.merge!(data)
      respond 400
    end
  end
end
