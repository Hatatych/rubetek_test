module Api
  class DashboardController < ApplicationController
    def status
      default_data
      @data.merge!(Worker.data).merge!(Task.data)
      add_hint
      render json: @data
    end
  end
end
