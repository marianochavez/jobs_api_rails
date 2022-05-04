Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :companies do
        resources :job_listings, only: [:create]
      end
      resources :job_listings, except: [:create]
      resources :candidates do
        resources :candidates_job_listings, only: [:create]
      end
      resources :candidates_job_listings, except: [:create]
    end
  end

end
