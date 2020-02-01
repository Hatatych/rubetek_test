module DataManager
  extend ActiveSupport::Concern

  def default_data
    @data ||= {
      request: {
        status: 200,
        message: 'OK'
      }
    }
  end

  def error_data(resource)
    @data ||= {
      request: {
        status: 400,
        message: 'Bad Request'
      },
      errors: {}.merge(resource.errors)
    }
  end

  def not_found_data(params)
    {
      request: {
        status: 404,
        message: params[:message].to_s,
        backtrace: params[:backtrace]
      }
    }
  end

  def respond(status = 200)
    render json: @data, status: status
  end
end
