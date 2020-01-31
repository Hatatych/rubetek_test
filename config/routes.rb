Rails.application.routes.draw do
  namespace :api do
    get 'tasks/status', to: 'tasks#dashboard'
    resources :task, only: :create do
      get 'status', to: 'tasks#status'
    end
  end
end
