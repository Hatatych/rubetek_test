module Api
  class TaskController < ApplicationController
    def status
      default_data
      task = Task.find(params[:task_id])
      @data.merge!(task.data)
      render json: @data
    rescue ActiveRecord::RecordNotFound => e
      data = not_found_data message: e.message, backtrace: e.backtrace[1..10]
      render json: @data.merge!(data)
    end

    def create
      @task = Task.new(task_params)
      default_data.merge!(@task.data) && respond if @task.save!
    rescue ActiveRecord::RecordInvalid
      data = error_data @task
      @data.merge!(data)
      respond 400
    end

    private

    def task_params
      params.require(:task).permit(:difficulty, :priority)
    end
  end
end
