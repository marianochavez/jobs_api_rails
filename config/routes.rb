Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'job_offers/index'
      get 'job_offers/show'
      resources :companies do
        resources :job_listings
      end
      resources :candidates
    end
  end

end
