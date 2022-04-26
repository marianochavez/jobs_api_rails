Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :companies do
        resources :job_listings
      end
      resources :candidates
      resources :candidates_job_listings
    end
  end

end
