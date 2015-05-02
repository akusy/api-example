Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show, :update, :destroy, :index, :create] do
      resources :articles, only: [:show, :update, :destroy, :index, :create]
    end
  end

end
