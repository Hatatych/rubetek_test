Rails.application.routes.draw do
  namespace :api do
    get 'status', to: 'dashboard#status'

    resources :task, only: :create do
      get 'status', to: 'task#status'
    end

    resources :worker, only: :create do
      get 'status', to: 'worker#status'
    end
  end
end
