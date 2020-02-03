module Api
  class BaseController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    http_basic_authenticate_with name: 'rubetek', password: 'rubetek'
  end
end
