Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :candidates

      resources :companies do
        resources :job_listings, only: [:create]
      end

      resources :job_listings, except: [:create] do
        member do
          post :apply
          delete :remove
        end
      end

      resources :candidates_job_listings, only: [:index, :show, :update]

    end
  end

end
